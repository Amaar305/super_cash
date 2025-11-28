
import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/account/account_deletion/domain/domain.dart';

class AccountDeletionRequestedUseCase
    implements UseCase<void, AccountDeletionRequestedUseCaseParams> {
  final AccountDeletionRepository accountDeletionRepository;

  const AccountDeletionRequestedUseCase({
    required this.accountDeletionRepository,
  });

  @override
  Future<Either<Failure, void>> call(
    AccountDeletionRequestedUseCaseParams param,
  ) async {
    return await accountDeletionRepository.accountDeletionRequested(
      reason: param.reason,
    );
  }
}

class AccountDeletionRequestedUseCaseParams {
  final String reason;

  const AccountDeletionRequestedUseCaseParams({required this.reason});
}
