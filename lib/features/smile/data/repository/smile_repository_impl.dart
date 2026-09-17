import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/smile/smile.dart';

class SmileRepositoryImpl implements SmileRepository {
  final SmileRemoteDataSource remoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const SmileRepositoryImpl({
    required this.remoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, SmilePlanResponse>> fetchPlans() async {
    try {
      final result = await remoteDataSource.fetchPlans();
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, SmileVerificationResult>> verifyEmail({
    required String email,
  }) async {
    try {
      final result = await remoteDataSource.verifyEmail(email: email);
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, TransactionResponse>> purchase({
    required String email,
    required String accountId,
    required String variationCode,
    required String phone,
  }) async {
    try {
      final result = await remoteDataSource.purchase(
        email: email,
        accountId: accountId,
        variationCode: variationCode,
        phone: phone,
      );
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, SmileTransactionStatus>> queryTransactionStatus({
    required String reference,
  }) async {
    try {
      final result = await remoteDataSource.queryTransactionStatus(
        reference: reference,
      );
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
