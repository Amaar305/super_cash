import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../verify.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSoure otpRemoteDataSoure;

  OtpRepositoryImpl({required this.otpRemoteDataSoure});

  @override
  Future<Either<Failure, Map>> verifyOTP(String otp, String email) async {
    try {
      final response = await otpRemoteDataSoure.verifyOTP(otp, email);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> requestOTP(String email) async {
    try {
      final res = await otpRemoteDataSoure.requestOTP(email);
      return right(res);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }
}
