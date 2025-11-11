import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OtpRepository {
  Future<Either<Failure, AppUser>> verifyOTP(String otp, String email);
  Future<Either<Failure, void>> requestOTP(String email);
}
