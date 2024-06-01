import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  final AuthUseCase _authUseCase;

  AuthProvider(this._authUseCase);

  Future<void> login(String email, String password) async {
    await _authUseCase.login(email, password);
    notifyListeners();
  }

  Future<void> logout(String? accessToken) async {
    await _authUseCase.logout(accessToken);
    clearUser();
  }

  Future<bool> hasToken() async {
    return await _authUseCase.hasToken();
  }

  Future<void> setUser(User user, String token) async {
    _user = user;
    _token = token;
    notifyListeners();
    const storage = FlutterSecureStorage();
    await storage.write(key: 'user', value: User.serialize(user));
    await storage.write(key: 'accessToken', value: token);
  }

  Future<void> clearUser() async {
    _user = null;
    _token = null;
    notifyListeners();
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'user');
    await storage.delete(key: 'accessToken');
  }

  Future<void> loadUser() async {
    _token = await _authUseCase.getAccessToken();
    if (_token != null) {
      _user = await _authUseCase.loadUser();
      notifyListeners();
    }
  }

  Future<int?> register(String name, String lastname, String studentCode,
      String email, String password) async {
    final register = await _authUseCase.register(name, lastname, studentCode, email, password);
    notifyListeners();
    return register;
  }
}
