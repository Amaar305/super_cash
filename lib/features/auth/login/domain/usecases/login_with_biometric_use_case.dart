import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/auth/login/login.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class LoginWithBiometricUseCase implements UseCase<AppUser, NoParam> {
  final LoginRepository loginRepository;

  LoginWithBiometricUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, AppUser>> call(NoParam param) async {
    return await loginRepository.fetchUserDetails();
  }
}
