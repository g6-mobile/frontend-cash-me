import 'package:dio/dio.dart';

import '../../utils/constants/api_constants.dart';

class TransactionService {
  final Dio dio;

  TransactionService() : dio = Dio();

  Future<int> createTransaction(String studentCode, String amount, String typeOperation, double latitude, double longitude) async {
    try {
      final response = await dio.post('${ApiConstants.baseURL}/auth/login',
          data: {'email': email, 'password': password});


      if (response.statusCode != 201) {
        throw Exception('Failed to create transaction');
      }

      return response.statusCode;
    } catch (e) {
      throw Exception(e);
    }
  }
}
