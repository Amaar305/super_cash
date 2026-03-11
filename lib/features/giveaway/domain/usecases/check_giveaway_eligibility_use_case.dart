import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CheckGiveawayEligibilityUseCase
    implements
        UseCase<GiveawayEligibilityResult, CheckGiveawayEligibilityParams> {
  final GiveawayRepository giveawayRepository;

  const CheckGiveawayEligibilityUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, GiveawayEligibilityResult>> call(
    CheckGiveawayEligibilityParams param,
  ) async {
    return await giveawayRepository.checkGiveawayEligibility(
      giveawayTypeId: param.giveawayTypeId,
    );
  }
}

class CheckGiveawayEligibilityParams {
  final String giveawayTypeId;

  const CheckGiveawayEligibilityParams({required this.giveawayTypeId});
}
