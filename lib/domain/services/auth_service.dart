import 'package:dio/dio.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('${ApiConstants.baseURL}/auth/login',
          data: {'email': email, 'password': password});

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      return User.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getToken() async {
    // Aquí debes implementar la lógica para obtener el token.
    // Este es solo un ejemplo y debes reemplazarlo con tu propia lógica.
    return await Future.delayed(Duration(seconds: 2), () => null);
  }
}