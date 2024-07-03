import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/services/user_service.dart';

class UserUseCase {
  final UserService _userService;

  UserUseCase(this._userService);

  Future<User?> getUserById(String id) async {
    return await _userService.getUserById(id);
  }
}
