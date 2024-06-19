import 'package:pocket_swap_fisi/domain/services/transaction_service.dart';

class TransactionUseCase {
  final TransactionService _transactionService;

  TransactionUseCase(this._transactionService);

  Future<int?> createTransaction(String studentCode, double amount,
      int typeOperation, double latitude, double longitude) async {
    final response = await _transactionService.createTransaction(
        studentCode, amount, typeOperation, latitude, longitude);
    return response;
  }
}
