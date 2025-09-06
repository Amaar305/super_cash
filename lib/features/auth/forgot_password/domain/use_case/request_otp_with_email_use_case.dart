import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/auth/forgot_password/forgot_password.dart';
import 'package:fpdart/fpdart.dart';

class RequestOtpWithEmailUseCase
    implements UseCase<Map, RequestOtpWithEmailParam> {
  final ForgotPasswordRepository forgotPasswordRepository;

  const RequestOtpWithEmailUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failure, Map>> call(RequestOtpWithEmailParam param) async {
    return await forgotPasswordRepository.requestOtpWithEmail(param.email);
  }
}

class RequestOtpWithEmailParam {
  final String email;

  const RequestOtpWithEmailParam({required this.email});
}
