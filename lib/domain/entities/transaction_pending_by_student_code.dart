class TransactionPendingByStudentCode {
  final Location location;

  final String id;
  final int initiatorCode;
  final double amount;
  final int status;
  final int operationType;
  final String createdAt;
  final String updatedAt;

  TransactionPendingByStudentCode({
    required this.location,
    required this.id,
    required this.initiatorCode,
    required this.amount,
    required this.status,
    required this.operationType,
    required this.createdAt,
    required this.updatedAt,
  });

  static TransactionPendingByStudentCode empty() {
    return TransactionPendingByStudentCode(
      location: Location(type: '', coordinates: []),
      id: '',
      initiatorCode: 0,
      amount: 0.0,
      status: 0,
      operationType: 0,
      createdAt: '',
      updatedAt: '',
    );
  }

  factory TransactionPendingByStudentCode.fromJson(Map<String, dynamic> json) {
    print('TransactionPendingByStudentCode: $json');
    return TransactionPendingByStudentCode(
      location: Location.fromJson(json['location']),
      id: json['_id'],
      initiatorCode: json['initiatorCode'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      operationType: json['operationType'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  static Map<String, dynamic> toJson(TransactionPendingByStudentCode model) =>
      <String, dynamic>{
        'location': Location.toJson(model.location),
        '_id': model.id,
        'initiatorCode': model.initiatorCode,
        'amount': model.amount,
        'status': model.status,
        'operationType': model.operationType,
        'created_at': model.createdAt,
        'updated_at': model.updatedAt,
      };
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

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
