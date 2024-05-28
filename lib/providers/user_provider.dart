import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  Future<User> getUser() async {
    final user = await _storage.read(key: 'user');
    return User.fromJson(user as Map<String, dynamic>);
  }
}
