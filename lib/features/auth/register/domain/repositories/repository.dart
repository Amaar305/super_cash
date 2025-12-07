import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class AuthResponse {
  final AppUser user;
  final String? message;

  const AuthResponse({required this.user, required this.message});
}

abstract interface class RegisterRepository {
  Future<Either<Failure, AuthResponse>> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String? referral,
  });
}
