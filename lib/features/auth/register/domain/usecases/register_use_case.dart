import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../domain.dart';

class RegisterUseCase implements UseCase<AuthUser, RegisterParam> {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});
  @override
  Future<Either<Failure, AuthUser>> call(RegisterParam param) async {
    return await registerRepository.register(
      email: param.email,
      phone: param.phone,
      firstName: param.firstName,
      lastName: param.lastName,
      password: param.password,
      confirmPassword: param.confirmPassword,
      referral: param.referral,
    );
  }
}

class RegisterParam {
  final String email;
  final String phone;
  final String? referral;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;

  const RegisterParam({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    this.referral,
  });
}
