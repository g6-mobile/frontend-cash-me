import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';

class AuthUseCase {
  final AuthService _authService;

  AuthUseCase(this._authService);

  Future<void> login(String email, String password, BuildContext context) async {
    final user = await _authService.login(email, password, context);    
    return user;
  }

  Future<void> logout(String? accessToken) async {
    await _authService.logout(accessToken);
  }

  Future<bool> hasToken() async {
    return await _authService.hasToken();
  }
}
