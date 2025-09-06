import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../repository/history_repositories.dart';

class FetchTransactionsUseCase
    implements UseCase<HistoryResponse, FetchTransactionsParams> {
  final HistoryRepositories historyRepositories;

  FetchTransactionsUseCase({required this.historyRepositories});

  @override
  Future<Either<Failure, HistoryResponse>> call(
    FetchTransactionsParams param,
  ) async {
    return await historyRepositories.fetchTransactions(
      param.page,
      start: param.start,
      end: param.end,
      status: param.status,
      transactionType: param.transactionType,
    );
  }
}

class FetchTransactionsParams {
  final int page;
  final DateTime? start;
  final DateTime? end;
  final TransactionStatus? status;
  final TransactionType? transactionType;

  FetchTransactionsParams({
    required this.page,
    this.start,
    this.end,
    this.status,
    this.transactionType,
  });
}
