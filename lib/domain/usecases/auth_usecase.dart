import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';

class AuthUseCase {
  final AuthService _authService;

  AuthUseCase(this._authService);

  Future<User> login(String email, String password) async {
    final user = await _authService.login(email, password);
    //PRINT INT CONSOLE
    print(user);
    return user;
  }

  Future<String?> getToken() async {
    return await _authService.getToken();
  }
}
