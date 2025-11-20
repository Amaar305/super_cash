import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../domain/repository/repository.dart';
import '../datasource/airtime_remote_data_source.dart';

class AirtimeRepositoryImpl implements AirtimeRepository {
  final AirtimeRemoteDataSource remoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const AirtimeRepositoryImpl({
    required this.remoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, TransactionResponse>> buyAirtime({
    required String mobileNumber,
    required String amount,
    required String network,
  }) async {
    try {
      final response = await remoteDataSource.buyAirtime(
        mobileNumber: mobileNumber,
        amount: amount,
        network: network,
      );
      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
