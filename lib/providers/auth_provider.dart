import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final AuthUseCase _authUseCase;

  AuthProvider(this._authUseCase);

  Future<void> login(String email, String password, BuildContext context) async {
    await _authUseCase.login(email, password, context);
    notifyListeners();
  }

  Future<void> logout(String? accessToken) async {
    await _authUseCase.logout(accessToken);
    notifyListeners();
  }

  Future<bool> hasToken() async {
    return await _authUseCase.hasToken();
  }

  Future<void> register(String name, String lastname, String studentCode, String email, String password) async {
    await _authUseCase.register(name, lastname, studentCode, email, password);
    notifyListeners();
  }
}