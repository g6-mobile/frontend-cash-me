import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/usecases/user_usecase.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;
  final UserUseCase _userUseCase;

  UserProvider(this._userUseCase);

  Future<void> getUserById(String id) async {
    _user = await _userUseCase.getUserById(id);
    notifyListeners();
  }
}
