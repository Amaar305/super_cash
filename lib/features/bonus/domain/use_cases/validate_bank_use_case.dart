import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/bonus/domain/domain.dart';

class ValidateBankUseCase
    implements UseCase<ValidatedBank, ValidateBankParams> {
  final BonusRepository bonusRepository;

  const ValidateBankUseCase({required this.bonusRepository});

  @override
  Future<Either<Failure, ValidatedBank>> call(ValidateBankParams param) async {
    return await bonusRepository.validateBankDetails(
      accountNumber: param.accountNumber,
      bankCode: param.bankCode,
    );
  }
}

class ValidateBankParams {
  final String bankCode;
  final String accountNumber;

  const ValidateBankParams({
    required this.bankCode,
    required this.accountNumber,
  });
}
