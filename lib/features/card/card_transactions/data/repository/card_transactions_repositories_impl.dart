import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../card_transactions.dart';

class CardTransactionsRepositoriesImpl implements CardTransactionsRepositories {
  final CardTransactionsRemoteDataSource cardTransactionsRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  CardTransactionsRepositoriesImpl({
    required this.cardTransactionsRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, CardTransactionsResponse>> fetchCardTransactions({
    required String cardId,
    int? page,
  }) async {
    try {
      final response = await cardTransactionsRemoteDataSource
          .fetchCardTransactions(cardId: cardId, page: page);
      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
