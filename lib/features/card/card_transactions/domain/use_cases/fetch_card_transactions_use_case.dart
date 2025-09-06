import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../card_transactions.dart';

class FetchCardTransactionsUseCase
    implements UseCase<CardTransactionsResponse, FetchCardTransactionsParams> {
  final CardTransactionsRepositories cardTransactionRepositories;

  FetchCardTransactionsUseCase({required this.cardTransactionRepositories});

  @override
  Future<Either<Failure, CardTransactionsResponse>> call(
    FetchCardTransactionsParams param,
  ) async {
    return await cardTransactionRepositories.fetchCardTransactions(
      cardId: param.cardId,
      page: param.page,
    );
  }
}

// class FetchCardTransactionsParams {
//   final String cardId;

//   FetchCardTransactionsParams({required this.cardId});
// }
class FetchCardTransactionsParams {
  final String cardId;
  final int? page;

  FetchCardTransactionsParams({required this.cardId, this.page});
}
