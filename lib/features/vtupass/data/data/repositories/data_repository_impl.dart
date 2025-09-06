import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

import '../../data.dart';

class DataRepositoryImpl implements DataRepository {
  final DataRemoteDataSource dataRemoteDataSource;

  DataRepositoryImpl({required this.dataRemoteDataSource});

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
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, DataPlanResponse>> fetchPlans({
    required String network,
  }) async {
    try {
      final res = await dataRemoteDataSource.fetchPlans(network: network);
      return right(res);
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
