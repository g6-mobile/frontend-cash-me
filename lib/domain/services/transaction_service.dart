import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/constants/api_constants.dart';

class TransactionService {
  final Dio dio;

  TransactionService() : dio = Dio();

  Future<int?> createTransaction(String studentCode, double amount,
      int typeOperation, double latitude, double longitude) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));

    try {
      print(
          'Datos de la transaccion: $studentCode, $amount, $typeOperation, $latitude, $longitude');


      response = await dio.post('${ApiConstants.baseURL}/transactions', data: {
        'initiatorCode': int.parse(studentCode),
        'amount': amount,
        'status': 1,
        'typeOperation': typeOperation,
        'longitude': longitude,
        'latitude': latitude
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      print('Response: ${response.statusCode}');

      return response.statusCode;
    } on DioException catch (_) {
      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    }
  }
}
