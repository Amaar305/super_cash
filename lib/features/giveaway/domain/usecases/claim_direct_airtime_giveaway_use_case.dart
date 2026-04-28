import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ClaimDirectAirtimeGiveawayUseCase
    implements UseCase<DirectAirtimeModel, ClaimDirectAirtimeGiveawayParams> {
  final GiveawayRepository giveawayRepository;

  const ClaimDirectAirtimeGiveawayUseCase({required this.giveawayRepository});
  @override
  Future<Either<Failure, DirectAirtimeModel>> call(
    ClaimDirectAirtimeGiveawayParams param,
  ) async {
    return await giveawayRepository.claimDirectAirtimeGiveaway(
      airtimeId: param.airtimeId,
      giveawayTypeId: param.giveawayTypeId,
    );
  }
}

class ClaimDirectAirtimeGiveawayParams {
  final String airtimeId;
  final String giveawayTypeId;

  const ClaimDirectAirtimeGiveawayParams({
    required this.airtimeId,
    required this.giveawayTypeId,
  });
}
