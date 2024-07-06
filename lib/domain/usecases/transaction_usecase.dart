import 'package:pocket_swap_fisi/domain/services/transaction_service.dart';

import '../entities/transaction_pending_by_student_code.dart';

class TransactionUseCase {
  final TransactionService _transactionService;

  TransactionUseCase(this._transactionService);

  Future<int?> createTransaction(String studentCode, double amount,
      int typeOperation, double latitude, double longitude) async {
    final response = await _transactionService.createTransaction(
        studentCode, amount, typeOperation, latitude, longitude);
    return response;
  }

  Future<TransactionPendingByStudentCode?> getTransactionPendingUseCase(
      String studentCode) async {
    final response = await _transactionService
        .getTransactionPendingByStudentCode(studentCode);
    return response;
  }

  Future<int?> updateStatusTransaction(String id, String studentCode, int status) async {
    final response = await _transactionService.updateStatusTransaction(
        id, studentCode, status);
    return response;
  }

}
