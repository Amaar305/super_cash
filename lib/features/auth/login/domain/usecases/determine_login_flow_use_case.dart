import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:token_repository/token_repository.dart';

/// Describes what should happen after a successful login attempt.
enum LoginFlowAction {
  requestTransactionPin,
  requestVerification,
  authenticateUser,
  promptBiometricEnrollment,
}

class LoginFlowDecision {
  const LoginFlowDecision(this.action);

  final LoginFlowAction action;
}

/// Determines the next logical step after a successful login.
class DetermineLoginFlowUseCase
    implements UseCase<LoginFlowDecision, AppUser> {
  DetermineLoginFlowUseCase({required TokenRepository tokenRepository})
      : _tokenRepository = tokenRepository;

  final TokenRepository _tokenRepository;

  @override
  Future<Either<Failure, LoginFlowDecision>> call(AppUser user) async {
    if (!user.transactionPin) {
      return Right(const LoginFlowDecision(LoginFlowAction.requestTransactionPin));
    }

    if (!user.isVerified) {
      return Right(const LoginFlowDecision(LoginFlowAction.requestVerification));
    }

    final biometricEnabled = _tokenRepository.getBiometric() ?? false;
    if (biometricEnabled) {
      return Right(const LoginFlowDecision(LoginFlowAction.authenticateUser));
    }

    return Right(const LoginFlowDecision(
      LoginFlowAction.promptBiometricEnrollment,
    ));
  }
}
