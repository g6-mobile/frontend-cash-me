import 'package:flutter/cupertino.dart';

import '../domain/usecases/transaction_usecase.dart';

class TransactionProvider extends ChangeNotifier{

  final TransactionUseCase _transactionUseCase;

  TransactionProvider(this._transactionUseCase);

  Future<int?> createTransaction(String studentCode, double amount, int typeOperation, double latitude, double longitude) async{
    final response = await _transactionUseCase.createTransaction(studentCode, amount, typeOperation, latitude, longitude);
    notifyListeners();
    return response;
  }
}