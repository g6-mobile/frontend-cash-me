import 'package:pocket_swap_fisi/domain/entities/user.dart';

abstract class LoginUseCase {
  Future<User> login(String email, String password);
}
