import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

abstract interface class GiveawayRepository {
  Future<Either<Failure, List<Giveaway>>> getGiveaways();
  Future<Either<Failure, List<GiveawayType>>> getGiveawaytypes();

  Future<Either<Failure, List<AirtimeGiveawayPin>>> getAirtimeGiveawayPins();

  Future<Either<Failure, GiveawayEligibilityResult>> checkGiveawayEligibility({
    required String giveawayTypeId,
  });

  Future<Either<Failure, AirtimeGiveawayPin>> claimGiveaway({
    required String giveawayTypeId,
    required String planid,
  });

  Future<Either<Failure, List<GiveawayHistory>>> getHistories();

  Future<Either<Failure, List<GiveawayWinner>>> getWinners();
}
