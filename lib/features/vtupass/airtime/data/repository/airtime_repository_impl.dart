import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../../../../core/error/exception.dart';
import '../../domain/repository/repository.dart';
import '../datasource/airtime_remote_data_source.dart';

class AirtimeRepositoryImpl implements AirtimeRepository {
  final AirtimeRemoteDataSource remoteDataSource;

  AirtimeRepositoryImpl({required this.remoteDataSource});
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
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
