import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/auth/forgot_password/forgot_password.dart';
import 'package:fpdart/fpdart.dart';

class ChangePasswordUseCase implements UseCase<Map, ChangePasswordParams> {
  final ForgotPasswordRepository forgotPasswordRepository;

  ChangePasswordUseCase(this.forgotPasswordRepository);
  @override
  Future<Either<Failure, Map>> call(ChangePasswordParams param) async {
    return await forgotPasswordRepository.changePassword(
      email: param.email,
      otp: param.otp,
      password: param.password,
      confirmPassword: param.confirmPassword,
    );
  }
}

class ChangePasswordParams {
  final String email;
  final String otp;
  final String password;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.email,
    required this.otp,
    required this.password,
    required this.confirmPassword,
  });
}
