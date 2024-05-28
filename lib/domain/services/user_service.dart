import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/utils/services/secure_storage.dart';

class UserService {
  final Dio dio;

  UserService(this.dio);

  Future<User?> loadUser() async {    
    const storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: 'user');
    //String? userJson = SecureStorage().readSecureData('user');
    if(userJson != null){
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }

  

}
