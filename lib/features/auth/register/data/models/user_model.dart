import 'dart:convert';

import '../../domain/domain.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.email,
    required super.phone,
    required super.firstName,
    required super.lastName,
    required super.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      email: map['email'] as String,
      phone: map['phone_number'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      message: map['message'] as String,
    );
  }

  const AuthUserModel.anonymousUser()
      : this(
          email: 'null',
          firstName: 'anonymous',
          lastName: 'User',
          phone: 'null',
          message: 'Couldn\'t sign up. Try again later.',
        );

  String get fullName => "$firstName  $lastName";

  String toJson() => json.encode(toMap());

  factory AuthUserModel.fromJson(String source) =>
      AuthUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
