import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ClaimProductGiveawayUseCase
    implements UseCase<ProductGiveawayModel, ClaimProductGiveawayParams> {
  final GiveawayRepository giveawayRepository;

const  ClaimProductGiveawayUseCase({required this.giveawayRepository});

  

  @override
  Future<Either<Failure, ProductGiveawayModel>> call(
    ClaimProductGiveawayParams param,
  ) async {
    return giveawayRepository.claimProductGiveaway(
      productId: param.productId,
      giveawayTypeId: param.giveawayTypeId,
    );
  }
}

class ClaimProductGiveawayParams {
  final String productId;
  final String giveawayTypeId;

  const ClaimProductGiveawayParams({
    required this.productId,
    required this.giveawayTypeId,
  });
}
