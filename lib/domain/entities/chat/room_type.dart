enum RoomType {
  personal,
  group,
}

extension RoomTypeExtension on RoomType {
  String get name {
    switch (this) {
      case RoomType.personal:
        return 'personal';
      case RoomType.group:
        return 'group';
      default:
        return '';
    }
  }

  static RoomType? fromString(String type) {
    switch (type) {
      case 'personal':
        return RoomType.personal;
      case 'group':
        return RoomType.group;
      default:
        return null;
    }
  }
}
