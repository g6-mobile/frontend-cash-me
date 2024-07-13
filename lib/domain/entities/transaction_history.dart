class TransactionHistoryResponse {
  final int statusCode;
  final TransactionData data;
  final String message;

  TransactionHistoryResponse(
      {required this.statusCode, required this.data, required this.message});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      statusCode: json['statusCode'],
      data: TransactionData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class TransactionData {
  final int count;
  final List<Transaction> transactions;

  TransactionData({required this.count, required this.transactions});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      count: json['count'],
      transactions: (json['transactions'] as List)
          .map((i) => Transaction.fromJson(i))
          .toList(),
    );
  }
}

class Transaction {
  final Location location;
  final String id;
  final int initiatorCode;
  final double amount;
  final int status;
  final int operationType;
  final String createdAt;
  final String updatedAt;
  final int approverCode;

  Transaction({
    required this.location,
    required this.id,
    required this.initiatorCode,
    required this.amount,
    required this.status,
    required this.operationType,
    required this.createdAt,
    required this.updatedAt,
    required this.approverCode,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        location: Location.fromJson(json['location']),
        id: json['_id'],
        initiatorCode: json['initiatorCode'],
        amount: json['amount'].toDouble(),
        status: json['status'],
        operationType: json['operationType'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        approverCode: json['approverCode']);
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates:
          List<double>.from(json['coordinates'].map((x) => x.toDouble())),
    );
  }

  static Map<String, dynamic> toJson(Location model) => <String, dynamic>{
        'type': model.type,
        'coordinates': model.coordinates,
      };
}
