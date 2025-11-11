import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../domain.dart';

class OtpUseCase implements UseCase<AppUser, OtpParam> {
  final OtpRepository otpRepository;

  OtpUseCase({required this.otpRepository});
  @override
  Future<Either<Failure, AppUser>> call(OtpParam param) async {
    return await otpRepository.verifyOTP(param.otp, param.email);
  }
}

class OtpParam {
  final String otp;
  final String email;

  const OtpParam({required this.otp, required this.email});
}

class RequestVerifyOtpUseCase implements UseCase<void, RequestVerifyOtpParams> {
  final OtpRepository otpRepository;

  RequestVerifyOtpUseCase({required this.otpRepository});
  @override
  Future<Either<Failure, void>> call(RequestVerifyOtpParams param) async {
    return await otpRepository.requestOTP(param.email);
  }
}

class RequestVerifyOtpParams {
  final String email;

  const RequestVerifyOtpParams({required this.email});
}
