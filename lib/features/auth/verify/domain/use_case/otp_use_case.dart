import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../domain.dart';

class OtpUseCase implements UseCase<Map, OtpParam> {
  final OtpRepository otpRepository;

  OtpUseCase({required this.otpRepository});
  @override
  Future<Either<Failure, Map>> call(OtpParam param) async {
    return await otpRepository.verifyOTP(param.otp);
  }
}

class OtpParam {
  final String otp;

  const OtpParam({required this.otp});
}
