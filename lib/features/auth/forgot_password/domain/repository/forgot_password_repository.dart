import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ForgotPasswordRepository {
  Future<Either<Failure, Map>> requestOtpWithEmail(String email);
  Future<Either<Failure, Map>> changePassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  });
}
