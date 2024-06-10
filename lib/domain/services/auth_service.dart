import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/studentByCode.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';
import 'package:pocket_swap_fisi/utils/providers/dio_provider.dart';

class AuthService {
  final Dio dio;

  AuthService() : dio = createDio();

  Future<void> login(String email, String password) async {
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
          options: Options(
              headers: {'Authorization': 'Bearer ${data['accessToken']}'}));

      if (user.statusCode != 200) {
        throw Exception('Failed to get user data');
      }

      final userData = User.fromJson(user.data['data']);

      await storage.write(key: 'user', value: User.serialize(userData));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');
    try {
      final response = await dio.get('${ApiConstants.baseURL}/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<StudentByCode> studentDataByCode(String studentCode) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));
    try {
      response = await dio.post('${ApiConstants.baseURL}/students/verify-code',
          data: {'code': studentCode}).timeout(
          const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      return StudentByCode.fromJson(response.data['data']);
    } on DioException catch (_) {
      if (response.statusCode != 500) {
        return StudentByCode(
            faculty: 'notFound', major: '', name: '', userPhoto: '');
      }

      return StudentByCode(
          faculty: 'error', major: '', name: '', userPhoto: '');
    } on TimeoutException catch (_) {
      return StudentByCode(
          faculty: 'error', major: '', name: '', userPhoto: '');
    }
  }

  Future<int?> validateEmail(String email) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));
    try {
      print("email: $email");
      response = await dio.post('${ApiConstants.baseURL}/students/verify-email', data: {
        'email': email,
      }).timeout(
          const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      return response.statusCode;
    } on DioException catch (e) {
      print("error: ${e.response?.statusCode ?? 500}");

      return e.response?.statusCode ?? 500;
    } on TimeoutException catch (_) {
      return 500;
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

  Future<int> register(String name, String lastName, String studentCode,
      String email, String password) async {
    int statusCode;
    try {
      final response =
          await dio.post('${ApiConstants.baseURL}/auth/register', data: {
        'firstName': name,
        'lastName': lastName,
        'email': email,
        'password': password,
        'studentCode': studentCode,
      });

      statusCode = response.statusCode ?? 500;
    } on DioError catch (e) {
      // Si hay un error en la solicitud, obtenemos el código de estado de la respuesta
      statusCode = e.response?.statusCode ?? 500;
    }

    print("statusCode: $statusCode");
    return statusCode;
  }

  Future<void> refreshToken() async {
    const storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: 'refreshToken');
    try {
      final response = await dio.get('${ApiConstants.baseURL}/auth/refresh',
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to refresh token');
      }

      final data = response.data['data'];

      await storage.write(key: 'accessToken', value: data['accessToken']);
      await storage.write(key: 'refreshToken', value: data['refreshToken']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> checkToken() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');
    try {
      final response = await dio.get('${ApiConstants.baseURL}/auth/check',
          options: Options(headers: {'Authorization ': 'Bearer $accessToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to check token');
      }
    } catch (e) {
      try {
        await refreshToken();
      } catch (e) {
        await logout();
      }
    }
  }

  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'accessToken');
  }

  Future<User?> loadUser() async {
    const storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: 'user');
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }
}
