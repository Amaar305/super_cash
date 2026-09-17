import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

class VerifySmileEmailUseCase
    implements UseCase<SmileVerificationResult, VerifySmileEmailParams> {
  final SmileRepository repository;

  const VerifySmileEmailUseCase({required this.repository});

  @override
  Future<Either<Failure, SmileVerificationResult>> call(
    VerifySmileEmailParams param,
  ) {
    return repository.verifyEmail(email: param.email);
  }
}

class VerifySmileEmailParams {
  final String email;

  const VerifySmileEmailParams({required this.email});
}
