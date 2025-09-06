import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class CardWithdrawRepositoriesImpl implements CardWithdrawRepositories {
  final CardWithdrawRemoteDataSource cardWithdrawRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  CardWithdrawRepositoriesImpl({
    required this.cardWithdrawRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, TransactionResponse>> cardWithdraw({
    required String amount,
    required String cardId,
  }) async {
    try {
      final response = await cardWithdrawRemoteDataSource.cardWithdraw(
        amount: amount,
        cardId: cardId,
      );
      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, Wallet>> fetchBalance() async {
    try {
      final response = await cardWithdrawRemoteDataSource.fetchBalance();
      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
