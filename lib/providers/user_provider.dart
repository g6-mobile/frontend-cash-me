import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/usecases/user_usecase.dart';

class UserProvider with ChangeNotifier {
  final UserUseCase _userUseCase;

  UserProvider(this._userUseCase);

}
