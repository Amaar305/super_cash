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
        final result = await giveawayRemoteDataSource.claimGiveaway(
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
}
