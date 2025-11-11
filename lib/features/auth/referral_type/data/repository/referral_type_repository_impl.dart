import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:super_cash/features/auth/referral_type/referral_type.dart';

class ReferralTypeRepositoryImpl implements ReferralTypeRepository {
  final ReferralTypeRemoteDataSource referralTypeRemoteDataSource;
  final NetworkInfo networkInfo;

  const ReferralTypeRepositoryImpl({
    required this.referralTypeRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReferralTypeEnrolResult>> enrollCompain({
    required String campaignId,
  }) async {
    try {
      // if (!await (networkInfo.isConnected)) {
      //   return left(NetworkFailure('No internet connection'));
      // }

      final result = await referralTypeRemoteDataSource.enrollCompain(
        campaignId: campaignId,
      );
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, ReferralTypeResult>> fetchCompains() async {
    try {
      // if (!await (networkInfo.isConnected)) {
      //   return left(NetworkFailure('No internet connection'));
      // }

      final result = await referralTypeRemoteDataSource.fetchCompains();
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }
}
