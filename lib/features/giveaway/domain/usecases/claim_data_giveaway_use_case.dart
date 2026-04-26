import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ClaimDataGiveawayUseCase
    implements UseCase<DataGiveawayItem, ClaimDataGiveawayParams> {
  final GiveawayRepository giveawayRepository;

  const ClaimDataGiveawayUseCase({required this.giveawayRepository});
  @override
  Future<Either<Failure, DataGiveawayItem>> call(
    ClaimDataGiveawayParams param,
  ) async {
    return await giveawayRepository.claimDataGiveaway(
      dataId: param.dataId,
      giveawayTypeId: param.giveawayTypeId,
      phone: param.phone,
    );
  }
}

class ClaimDataGiveawayParams {
  final String dataId;
  final String giveawayTypeId;
  final String phone;

  const ClaimDataGiveawayParams({
    required this.dataId,
    required this.giveawayTypeId,
    required this.phone,
  });
}
