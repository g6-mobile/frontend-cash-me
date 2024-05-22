import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<User> login(String email, String password) async {
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
      
      return User.fromJson(data['user']);
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
