import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'messages.dart';

class Chat {
  List<User> users;
  List<Messages> messages;

  Chat({
    required this.users,
    required this.messages,
  });

  Chat copyWith({
    List<User>? users,
    List<Messages>? messages,
  }) {
    return Chat(
      users: users ?? this.users,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users,
      'messages': messages,
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() => "Chat(users: $users,messages: $messages)";

  @override
  int get hashCode => Object.hash(users, messages);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat &&
          runtimeType == other.runtimeType &&
          users == other.users &&
          messages == other.messages;
}
