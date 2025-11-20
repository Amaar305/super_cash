import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../data.dart';

class DataRepositoryImpl implements DataRepository {
  final DataRemoteDataSource dataRemoteDataSource;

  final ApiErrorHandler apiErrorHandler;

  const DataRepositoryImpl({
    required this.dataRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, TransactionResponse>> buyDataPlan({
    required String network,
    required String planId,
    required String phoneNumber,
  }) async {
    try {
      final res = await dataRemoteDataSource.buyDataPlan(
        network: network,
        planId: planId,
        phoneNumber: phoneNumber,
      );
      return right(res);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, DataPlanResponse>> fetchPlans({
    required String network,
  }) async {
    try {
      final res = await dataRemoteDataSource.fetchPlans(network: network);
      return right(res);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
