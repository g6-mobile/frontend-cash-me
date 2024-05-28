import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';
import 'package:pocket_swap_fisi/domain/usecases/user_usecase.dart';
import 'package:pocket_swap_fisi/utils/services/secure_storage.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;

  UserProvider(this._authUseCase, this._userUseCase);

  Future<void> setUser(User user, String token) async {
    _user = user;
    _token = token;
    notifyListeners();
    SecureStorage().writeSecureData('user', User.serialize(user));
    SecureStorage().writeSecureData('accessToken', token);
  }

  Future<void> clearUser() async {
    _user = null;
    _token = null;
    notifyListeners();
    SecureStorage().deleteSecureData('user');
    SecureStorage().deleteSecureData('accessToken');
  }

  Future<void> loadUser() async {
    _token = await _authUseCase.getAccessToken();
    if (_token != null) {
      _user = await _userUseCase.loadUser();
      notifyListeners();
    }
  }
}
