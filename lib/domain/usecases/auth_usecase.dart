import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';

import '../entities/studentByCode.dart';

class AuthUseCase {
  final AuthService _authService;

  AuthUseCase(this._authService);

  Future<void> login(String email, String password) async {
    final user = await _authService.login(email, password);
    return user;
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<bool> hasToken() async {
    return await _authService.hasToken();
  }

  Future<String?> getAccessToken() async {
    return await _authService.getAccessToken();
  }

  Future<User?> loadUser() async {
    return await _authService.loadUser();
  }

  Future<int?> register(String name, String lastName, String studentCode,
      String email, String password) async {
    final user = await _authService.register(
        name, lastName, studentCode, email, password);
    return user;
  }

  Future<StudentByCode> studentByCode(String studentCode) async {
    final student = await _authService.studentDataByCode(studentCode);
    return student;
  }

  Future<int?> validateEmail(String email) async {
    final response = await _authService.validateEmail(email);
    return response;
  }
}
