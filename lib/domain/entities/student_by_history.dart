import 'dart:convert';

class StudentByCodeHistory {
  final String faculty;
  final String major;
  final String name;
  final String userPhoto;

  StudentByCodeHistory({
    required this.faculty,
    required this.major,
    required this.name,
    required this.userPhoto,
  });

  factory StudentByCodeHistory.fromJson(Map<String, dynamic> json) {
    return StudentByCodeHistory(
      faculty: json['faculty'],
      major: json['major'],
      name: json['name'],
      userPhoto: json['userPhoto'],
    );
  }

  static Map<String, dynamic> toJson(StudentByCodeHistory model) => <String, dynamic>{
    'faculty': model.faculty,
    'major': model.major,
    'name': model.name,
    'userPhoto': model.userPhoto,
  };
}