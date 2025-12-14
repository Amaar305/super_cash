import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:super_cash/features/add_fund/add_fund.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class AddFundRepositoryImpl implements AddFundRepository {
  final AddFundRemoteDataSource remoteDataSource;
  final ApiErrorHandler apiErrorHandler;
  final NetworkInfo networkInfo;

  AddFundRepositoryImpl({
    required this.remoteDataSource,
    required this.apiErrorHandler,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Account>>> fetchBankAccounts() async {
    if (!await networkInfo.isConnected) {
      return left(NetworkFailure("No internet connection."));
    }
    try {
      final result = await remoteDataSource.fetchBankAccounts();
      return Right(result);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, String>> generateAccount({required String bvn}) async {
    try {
      if (!await networkInfo.isConnected) {
        return left(NetworkFailure("No internet connection."));
      }
      final result = await remoteDataSource.generateAccount(bvn: bvn);
      return Right(result);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }
}
