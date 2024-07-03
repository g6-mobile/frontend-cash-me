import 'package:pocket_swap_fisi/domain/entities/user.dart';

class Room {
  String id;
  List<User> members;
  String type;

  Room({
    required this.id,
    required this.members,
    required this.type,
  });

  Room copyWith({
    String? id,
    List<User>? members,
    String? type,
  }) {
    return Room(
      id: id ?? this.id,
      members: members ?? this.members,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'members': members,
      'type': type,
    };
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
    );
  }

  @override
  String toString() => "Room(id: $id,members: $members,type: $type)";

  @override
  int get hashCode => Object.hash(id, members, type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Room &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          members == other.members &&
          type == other.type;
}
