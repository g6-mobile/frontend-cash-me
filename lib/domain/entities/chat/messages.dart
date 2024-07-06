class Messages {
  String? id;
  String content;
  String senderId;
  String? roomId;
  String? createdAt;
  String? updatedAt;

  Messages({
    this.id,
    required this.content,
    required this.senderId,
    this.roomId,
    this.createdAt,
    this.updatedAt,
  });

  Messages copyWith({
    String? id,
    String? content,
    String? senderId,
    String? roomId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Messages(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'sender_id': senderId,
      'roomId': roomId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['_id'] as String?,
      content: json['content'] as String,
      senderId: json['sender_id'] as String,
      roomId: json['roomId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  @override
  String toString() =>
      "Messages(id: $id,content: $content,senderId: $senderId,roomId: $roomId,createdAt: $createdAt,updatedAt: $updatedAt)";

  @override
  int get hashCode =>
      Object.hash(id, content, senderId, roomId, createdAt, updatedAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Messages &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          senderId == other.senderId &&
          roomId == other.roomId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;
}
