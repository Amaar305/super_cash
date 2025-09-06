import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/change_password_repository.dart';

class ChangePasswordUseCase implements UseCase<String, ChangePasswordParams> {
  final ChangePasswordRepository changePasswordRepository;

  const ChangePasswordUseCase({required this.changePasswordRepository});

  @override
  Future<Either<Failure, String>> call(ChangePasswordParams param) async {
    return await changePasswordRepository.changePassword(
      currentPassword: param.currentPassword,
      newPassword: param.newPassword,
      confirmPassword: param.confirmPassword,
    );
  }
}

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
