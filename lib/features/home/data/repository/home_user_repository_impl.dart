import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../home.dart';

class HomeUserRepositoryImpl implements HomeUserRepository {
  final HomeUserRemoteDataSource homeUserRemoteDataSource;
  // final ApiErrorHandler apiErrorHandler;

  const HomeUserRepositoryImpl({
    required this.homeUserRemoteDataSource,
    required this.networkInfo,
    // required this.apiErrorHandler,
  });

  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, AppUser>> fetchUserDetails() async {
    try {
      if (!await networkInfo.isConnected) {
        return left(NetworkFailure("No internet connection."));
      }
      final res = await homeUserRemoteDataSource.fetchUserDetails();

      return right(res);
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, HomeSettings>> fetchAppSettings({
    required String platform,
    required String version,
    required String versionCode,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return left(NetworkFailure("No internet connection."));
      }
      final res = await homeUserRemoteDataSource.fetchAppSettings(
        platform: platform,
        version: version,
        versionCode: versionCode,
      );

      return right(res);
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
