import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/referal/referal.dart';

class ReferalRepositoryImpl implements ReferalRepository {
  final ReferalRemoteDataSource referalRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  ReferalRepositoryImpl({
    required this.referalRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, ReferralResult>> claimMyRewards({
    required List<String> refereeIds,
    required String idms,
  }) async {
    try {
      final result = await referalRemoteDataSource.claimMyRewards(
        refereeIds: refereeIds,
        idms: idms,
      );

      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, List<ReferralUser>>> fetchMyReferrals() async {
    try {
      final result = await referalRemoteDataSource.fetchMyReferrals();

      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
