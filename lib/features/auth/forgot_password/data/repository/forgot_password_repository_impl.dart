import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../forgot_password.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  ForgotPasswordRepositoryImpl({required this.forgotPasswordRemoteDataSource});

  @override
  Future<Either<Failure, Map>> changePassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await forgotPasswordRemoteDataSource.changePassword(
        email: email,
        otp: otp,
        password: password,
        confirmPassword: confirmPassword,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map>> requestOtpWithEmail(String email) async {
    try {
      final response = await forgotPasswordRemoteDataSource.requestOtpWithEmail(
        email,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
