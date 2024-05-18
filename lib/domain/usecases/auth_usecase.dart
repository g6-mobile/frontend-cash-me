import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';

class AuthUseCase {
  final AuthService _authService;

  AuthUseCase(this._authService);

  Future<User> login(String email, String password) async {
    return await _authService.login(email, password);
  }
}
