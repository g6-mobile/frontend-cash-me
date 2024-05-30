class Transaction {
  final String personName;
  final double amount;
  final DateTime date;

  Transaction({
    required this.personName,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      personName: json['personName'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personName': personName,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
