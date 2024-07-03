import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';
import 'package:pocket_swap_fisi/utils/providers/dio_provider.dart';

class UserService {
  final Dio dio;

  UserService(): dio = createDio();

  Future<User?> getUserById(String id) async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');
    try {
      final response = await dio.get('${ApiConstants.baseURL}/users/$id',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to get user');
      }

      return User.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

}
