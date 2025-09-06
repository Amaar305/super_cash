import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:super_cash/features/history/history.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class HistoryRepositoriesImpl implements HistoryRepositories {
  final HistoryRemoteDataSource historyRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;
  final NetworkInfo networkInfo;

  HistoryRepositoriesImpl({
    required this.historyRemoteDataSource,
    required this.apiErrorHandler,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, HistoryResponse>> fetchTransactions(
    int page, {
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? transactionType,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return left(NetworkFailure("No internet connection."));
      }
      final response = await historyRemoteDataSource.fetchTransactions(
        page,
        start: start,
        end: end,
        status: status,
        transactionType: transactionType,
      );
      return right(response);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
