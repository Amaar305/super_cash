import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayRepositoryImpl implements GiveawayRepository {
  final GiveawayRemoteDataSource giveawayRemoteDataSource;
  final NetworkInfo networkInfo;
  final ApiErrorHandler apiErrorHandler;

  const GiveawayRepositoryImpl({
    required this.giveawayRemoteDataSource,
    required this.networkInfo,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, GiveawayEligibilityResult>> checkGiveawayEligibility({
    required String giveawayTypeId,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.checkGiveawayEligibility(
          giveawayTypeId: giveawayTypeId,
        );
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, AirtimeGiveawayPin>> claimGiveaway({
    required String giveawayTypeId,
    required String planid,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.claimPINGiveaway(
          giveawayTypeId: giveawayTypeId,
          planid: planid,
        );
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<AirtimeGiveawayPin>>>
  getAirtimeGiveawayPins() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getAirtimeGiveawayPins();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<GiveawayHistory>>> getHistories() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getHistories();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<GiveawayType>>> getGiveawaytypes() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getGiveawayTypes();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<Giveaway>>> getGiveaways() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getGiveaways();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<GiveawayWinner>>> getWinners() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getWinners();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<ProductGiveawayModel>>>
  getProductsGiveaway() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getProductsGiveaway();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, ProductGiveawayModel>> claimProductGiveaway({
    required String productId,
    required String giveawayTypeId,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(NetworkFailure('No internet connection!'));
      }

      final result = await giveawayRemoteDataSource.claimProductGiveaway(
        productId: productId,
        giveawayTypeId: giveawayTypeId,
      );
      return right(result);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, ProductClaimAddressModel>> addProductDeliveryAddress({
    required String productId,
    required String fullName,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(NetworkFailure('No internet connection!'));
      }
      final result = await giveawayRemoteDataSource.addProductDeliveryAddress(
        productId: productId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
      );
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<DataGiveawayItem>>> getDataGiveaways() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.getDataGiveaways();
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, DataGiveawayItem>> claimDataGiveaway({
    required String dataId,
    required String giveawayTypeId,
    required String phone,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final result = await giveawayRemoteDataSource.claimDataGiveaway(
          dataId: dataId,
          giveawayTypeId: giveawayTypeId,
          phone: phone,
        );
        return Right(result);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, UserCashAccountDetailModel>> addCashAccountDetails({
    required String cashId,
    required String accountName,
    required String accountNumber,
    required String bankName,
    String? bankCode,
    String? phoneNumber,
  }) async{
    // TODO: implement addCashAccountDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CashGiveawayItem>> claimCashGiveaway({
    required String cashId,
    required String giveawayTypeId,
  }) {
    // TODO: implement claimCashGiveaway
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CashGiveawayItem>>> getCashGiveaways() {
    // TODO: implement getCashGiveaways
    throw UnimplementedError();
  }
}
