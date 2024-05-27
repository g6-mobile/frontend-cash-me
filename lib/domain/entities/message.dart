class Message {
  String sender;
  String message;

  Message({required this.sender, required this.message});

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'] as String,
      message: json['message'] as String,
    );
  }

  @override
  String toString() => 'Message{sender: $sender, message: $message}';

  @override
  int get hashCode => Object.hash(sender, message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          sender == other.sender &&
          message == other.message;
}
