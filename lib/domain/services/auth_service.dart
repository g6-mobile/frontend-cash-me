import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<void> login(String email, String password, BuildContext context) async {    
    try {
      final response = await dio.post('${ApiConstants.baseURL}/auth/login',
          data: {'email': email, 'password': password});

      if (response.statusCode != 201) {
        throw Exception('Failed to login');
      }

      final data = response.data['data'];

      // Guardar el token en el almacenamiento seguro
      const storage = FlutterSecureStorage();
      await storage.write(key: 'accessToken', value: data['accessToken']);
      await storage.write(key: 'refreshToken', value: data['refreshToken']);

      final user = await dio.get('${ApiConstants.baseURL}/users/me',
          options: Options(headers: {'Authorization': 'Bearer ${data['accessToken']}'}));
      
      // userProvider.setUser(User.fromJson(user.data['data']));            
      await storage.write(key: 'user', value: user.data['data'].toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout(String? accessToken) async {
    try {
      final response = await dio.get('${ApiConstants.baseURL}/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to logout');
      }

      // Eliminar el token del almacenamiento seguro
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> hasToken() async {
    try {
      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'accessToken');
      // final refreshToken = await storage.read(key: 'refreshToken');

      return accessToken != null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
