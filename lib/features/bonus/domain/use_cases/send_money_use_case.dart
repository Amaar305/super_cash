import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/bonus/domain/domain.dart';

class SendMoneyUseCase
    implements UseCase<Map<String, dynamic>, SendMoneyParams> {
  final BonusRepository bonusRepository;

  const SendMoneyUseCase({required this.bonusRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(SendMoneyParams param) {
    return bonusRepository.sendMoney(
      accountNumber: param.accountNumber,
      bankCode: param.bankCode,
      amount: param.amount,
      accountName: param.accountName,
    );
  }
}

class SendMoneyParams {
  final String accountNumber;
  final String bankCode;
  final String amount;
  final String accountName;

  const SendMoneyParams({
    required this.accountNumber,
    required this.bankCode,
    required this.amount,
    required this.accountName,
  });
}
