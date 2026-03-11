import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ClaimAirtimeGiveawayUseCase
    implements UseCase<AirtimeGiveawayPin, ClaimAirtimeGiveawayParams> {
  final GiveawayRepository giveawayRepository;

  const ClaimAirtimeGiveawayUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, AirtimeGiveawayPin>> call(
    ClaimAirtimeGiveawayParams param,
  ) async {
    return await giveawayRepository.claimGiveaway(
      giveawayTypeId: param.giveawayId,
      planid: param.planId,
    );
  }
}

class ClaimAirtimeGiveawayParams {
  final String giveawayId;
  final String planId;

  const ClaimAirtimeGiveawayParams({
    required this.giveawayId,
    required this.planId,
  });
}
