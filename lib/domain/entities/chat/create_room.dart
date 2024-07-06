import 'package:pocket_swap_fisi/domain/entities/chat/room_type.dart';

class CreateRoom {
  String? name;
  List<String> members;
  RoomType? type;

  CreateRoom({
    this.name,
    required this.members,
    this.type = RoomType.personal, // Default value
  });

  CreateRoom copyWith({
    String? name,
    List<String>? members,
    RoomType? type,
  }) {
    return CreateRoom(
      name: name ?? this.name,
      members: members ?? this.members,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'members': members,
      'type': type?.name,
    };
  }

  factory CreateRoom.fromJson(Map<String, dynamic> json) {
    return CreateRoom(
      name: json['name'] as String?,
      members: List<String>.from(json['members']),
      type: RoomTypeExtension.fromString(json['type'] as String) ?? RoomType.personal, // Ensure default value if not provided
    );
  }

  @override
  String toString() => "CreateRoom(name: $name, members: $members, type: $type)";

  @override
  int get hashCode => Object.hash(name, members, type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateRoom &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          members == other.members &&
          type == other.type;
}
