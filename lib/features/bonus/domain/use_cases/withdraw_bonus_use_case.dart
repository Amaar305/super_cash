import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/bonus/domain/domain.dart';

class WithdrawBonusUseCase
    implements UseCase<Map<String, dynamic>, WithdrawBonusParams> {
  final BonusRepository bonusRepository;

  const WithdrawBonusUseCase({required this.bonusRepository});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    WithdrawBonusParams param,
  ) async {
    return await bonusRepository.withdrawBonus(amount: param.amount);
  }
}

class WithdrawBonusParams {
  final String amount;

  const WithdrawBonusParams({required this.amount});
}
