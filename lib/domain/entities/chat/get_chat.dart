class GetChat {
  String? lastId;
  int? limit;

  GetChat({
    this.lastId,
    this.limit = 10,
  });

  GetChat copyWith({
    String? lastId,
    int? limit,
  }) {
    return GetChat(
      lastId: lastId ?? this.lastId,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastId': lastId,
      'limit': limit,
    };
  }

  factory GetChat.fromJson(Map<String, dynamic> json) {
    return GetChat(
      lastId: json['lastId'] as String?,
      limit: json['limit'] as int? ?? 10,
    );
  }

  @override
  String toString() => "GetChat(lastId: $lastId, limit: $limit)";

  @override
  int get hashCode => Object.hash(lastId, limit);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetChat &&
          runtimeType == other.runtimeType &&
          lastId == other.lastId &&
          limit == other.limit;
}
