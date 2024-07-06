import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/constants/api_constants.dart';
import '../entities/transaction_pending_by_student_code.dart';

class TransactionService {
  final Dio dio;

  TransactionService() : dio = Dio();

  Future<int?> createTransaction(String studentCode, double amount,
      int typeOperation, double latitude, double longitude) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));

    try {

      response = await dio.post('${ApiConstants.baseURL}/transactions', data: {
        'initiatorCode': studentCode,
        'amount': amount,
        'status': 1,
        'operationType': typeOperation,
        'longitude': longitude,
        'latitude': latitude
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      print('Response: ${response}');

      return response.statusCode;
    } on DioException catch (e) {
      print('Error: ${e.response?.statusMessage} , ${e.response?.data} , ${e.response?.statusCode} , ${e.response?.extra}');
      return response.statusCode;
    } on TimeoutException catch (e) {
      print('Error: ${e.message}');
      return 500;
    }
  }


  Future<TransactionPendingByStudentCode?> getTransactionPendingByStudentCode(
      String studentCode) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));

    try {
      print('Codigo de estudiante: $studentCode');
      response = await dio
          .get('${ApiConstants.baseURL}/transactions/$studentCode/pending/')
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      print('Response: $response');

      if (response.data['data'] != null) {
        return TransactionPendingByStudentCode.fromJson(response.data['data']);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print('Error: ${response.statusMessage}');
      return null;
    } on TimeoutException catch (e) {
      print('Error: ${response.statusMessage}');
      return null;
    }
  }

  Future<int?> updateStatusTransaction(String id, String studentCode, int status) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));

    try {
      response = await dio.put('${ApiConstants.baseURL}/transactions/$id', data: {
        'approverCode': studentCode,
        'status': status
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      print('Response: $response');

      return response.statusCode;
    } on DioException catch (_) {
      print('Error: ${response.statusMessage}');
      return response.statusCode;
    } on TimeoutException catch (_) {
      print('Error: ${response.statusMessage}');
      return 500;
    }
  }
}
