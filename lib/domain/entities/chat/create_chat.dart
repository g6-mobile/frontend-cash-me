class CreateChat {
  String roomId;
  String content;

  CreateChat({
    required this.roomId,
    required this.content,
  });

  CreateChat copyWith({
    String? roomId,
    String? content,
  }) {
    return CreateChat(
      roomId: roomId ?? this.roomId,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'content': content,
    };
  }

  factory CreateChat.fromJson(Map<String, dynamic> json) {
    return CreateChat(
      roomId: json['roomId'] as String,
      content: json['content'] as String,
    );
  }

  @override
  String toString() => "CreateChat(roomId: $roomId,content: $content)";

  @override
  int get hashCode => Object.hash(roomId, content);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateChat &&
          runtimeType == other.runtimeType &&
          roomId == other.roomId &&
          content == other.content;
}