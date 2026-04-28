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
  Future<Either<Failure, List<ProductGiveawayModel>>> getProductsGiveaway();
  Future<Either<Failure, ProductGiveawayModel>> claimProductGiveaway({
    required String productId,
    required String giveawayTypeId,
  });

  Future<Either<Failure, ProductClaimAddressModel>> addProductDeliveryAddress({
    required String productId,
    required String fullName,
    required String phoneNumber,
    required String address,
  });

  Future<Either<Failure, List<DataGiveawayItem>>> getDataGiveaways();

  Future<Either<Failure, DataGiveawayItem>> claimDataGiveaway({
    required String dataId,
    required String giveawayTypeId,
    required String phone,
  });

  Future<Either<Failure, List<CashGiveawayItem>>> getCashGiveaways();
  Future<Either<Failure, CashGiveawayItem>> claimCashGiveaway({
    required String cashId,
    required String giveawayTypeId,
  });

  Future<Either<Failure, UserCashAccountDetailModel>> addCashAccountDetails({
    required String cashId,
    required String accountName,
    required String accountNumber,
    required String bankName,
    String? bankCode,
    String? phoneNumber,
  });

  Future<Either<Failure, List<DirectAirtimeModel>>> getDirectAirtimesGiveaway();

  Future<Either<Failure, DirectAirtimeModel>> claimDirectAirtimeGiveaway({
    required String airtimeId,
    required String giveawayTypeId,
  });

  Future<Either<Failure, UserDirectAirtimePhoneModel>>
  addPhoneForClaimedDirectAirtimeGiveaway({
    required String airtimeId,
    required String phoneNumber,
  });
}
