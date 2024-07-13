import 'package:pocket_swap_fisi/domain/entities/transaction_pending_by_student_code.dart';

class TransactionResponse {
  final int statusCode;
  final Data data;
  final String message;

  TransactionResponse({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      statusCode: json['statusCode'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final int count;
  final List<TransactionPendingByStudentCode> transactions;

  Data({
    required this.count,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      count: json['count'],
      transactions: List<TransactionPendingByStudentCode>.from(
        json['transactions'].map(
              (transaction) => TransactionPendingByStudentCode.fromJson(transaction),
        ),
      ),
    );
  }
}