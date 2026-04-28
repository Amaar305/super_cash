import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ClaimCashGiveawayUseCase
    implements UseCase<CashGiveawayItem, ClaimCashGiveawayParams> {
  final GiveawayRepository giveawayRepository;

  const ClaimCashGiveawayUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, CashGiveawayItem>> call(
    ClaimCashGiveawayParams param,
  ) async {
    return await giveawayRepository.claimCashGiveaway(
      cashId: param.cashId,
      giveawayTypeId: param.giveawayTypeId,
    );
  }
}

class ClaimCashGiveawayParams {
  final String cashId;
  final String giveawayTypeId;

  const ClaimCashGiveawayParams({
    required this.cashId,
    required this.giveawayTypeId,
  });
}
