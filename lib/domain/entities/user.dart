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

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'studentCode': studentCode,
      'faculty': faculty,
      'major': major,
      'userPhoto': userPhoto,
      'password': password,
      'role': role.toString().split('.').last,
      'googleId': googleId,
      'refreshToken': refreshToken,
    };
  }
}

enum UserRole { admin, user }
