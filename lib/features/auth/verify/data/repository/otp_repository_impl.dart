import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../verify.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSoure otpRemoteDataSoure;

  OtpRepositoryImpl({required this.otpRemoteDataSoure});

  @override
  Future<Either<Failure, Map>> verifyOTP(String otp) async {
    try {
      final response = await otpRemoteDataSoure.verifyOTP(otp);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
