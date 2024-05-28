import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String? studentCode;
  final String? faculty;
  final String? major;
  final String userPhoto;
  final String? password;
  final UserRole role;
  final String? googleId;
  final String? refreshToken;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.studentCode,
    this.faculty,
    this.major,
    required this.userPhoto,
    this.password,
    required this.role,
    this.googleId,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      studentCode: json['studentCode'],
      faculty: json['faculty'],
      major: json['major'],
      userPhoto: json['userPhoto'],
      password: json['password'],
      role: UserRole.values
          .firstWhere((e) => e.toString() == 'UserRole.${json['role']}'),
      googleId: json['googleId'],
      refreshToken: json['refreshToken'],
    );
  }

  static Map<String, dynamic> toJson(User model) => <String, dynamic>{
        'firstName': model.firstName,
        'lastName': model.lastName,
        'email': model.email,
        'studentCode': model.studentCode,
        'faculty': model.faculty,
        'major': model.major,
        'userPhoto': model.userPhoto,
        'password': model.password,
        'role': model.role.toString().split('.').last,
        'googleId': model.googleId,
        'refreshToken': model.refreshToken,
      };

  static String serialize(User model) => json.encode(User.toJson(model));

  static User deserialize(String json) => User.fromJson(jsonDecode(json));
}

enum UserRole { admin, user }
