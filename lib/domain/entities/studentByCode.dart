import 'dart:convert';

class StudentByCode{
  final String faculty;
  final String major;
  final String name;
  final String userPhoto;

  StudentByCode({
    required this.faculty,
    required this.major,
    required this.name,
    required this.userPhoto,
  });

  factory StudentByCode.fromJson(Map<String, dynamic> json) {
    return StudentByCode(
      faculty: json['faculty'],
      major: json['major'],
      name: json['name'],
      userPhoto: json['userPhoto'],
    );
  }

  static Map<String, dynamic> toJson(StudentByCode model) => <String, dynamic>{
    'faculty': model.faculty,
    'major': model.major,
    'name': model.name,
    'userPhoto': model.userPhoto,
  };
}