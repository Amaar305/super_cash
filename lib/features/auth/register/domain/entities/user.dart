import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String message;

  const AuthUser({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.message,
  });

  @override
  List<Object?> get props => [email, phone, firstName, lastName, message];
}
