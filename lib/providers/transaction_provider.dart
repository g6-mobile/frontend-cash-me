import 'package:flutter/cupertino.dart';
import '../domain/entities/transaction_history.dart';
import '../domain/entities/transaction_pending_by_student_code.dart';
import '../domain/entities/transactions_for_map.dart';
import '../domain/usecases/transaction_usecase.dart';

class TransactionProvider extends ChangeNotifier {
  TransactionPendingByStudentCode? _transactionPending;
  TransactionPendingByStudentCode? get transactionPending => _transactionPending;

  TransactionResponse? _transactionsForMap;
  TransactionResponse? get transactionsForMap => _transactionsForMap;

  TransactionHistoryResponse? _transactionHistory;
  TransactionHistoryResponse? get transactionHistory => _transactionHistory;

  final TransactionUseCase _transactionUseCase;

  TransactionProvider(this._transactionUseCase);

  Future<int?> createTransaction(String studentCode, double amount,
      int typeOperation, double latitude, double longitude) async {
    final response = await _transactionUseCase.createTransaction(
        studentCode, amount, typeOperation, latitude, longitude);
    notifyListeners();
    return response;
  }

  Future<void> getTransactionPendingProvider(
      String studentCode) async {
    final response = await _transactionUseCase
        .getTransactionPendingUseCase(studentCode);
    _transactionPending = response ?? TransactionPendingByStudentCode.empty();
    notifyListeners();
  }

  Future<int?> updateStatusTransaction(String id, String studentCode, int status) async {
    final response = await _transactionUseCase.updateStatusTransaction(
        id, studentCode, status);
    notifyListeners();
    return response;
  }

  Future<void> getTransactionsForMapProvider(String studentCode) async {
    final response = await _transactionUseCase.getTransactionsForMapUseCase(studentCode);
    _transactionsForMap = response;
    notifyListeners();
  }

  Future<void> getTransactionsHistoryProvider(String studentCode) async {
    final response = await _transactionUseCase.getTransactionsHistoryUseCase(studentCode);
    _transactionHistory = response;
    notifyListeners();
  }
}