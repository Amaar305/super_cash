import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/card/fund_card/fund_card.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class FundCardRepositoriesImpl implements FundCardRepositories {
  final FundCardRemoteDataSource fundCardRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

 const FundCardRepositoriesImpl({
    required this.fundCardRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, TransactionResponse>> fundCard({
    required String amount,
    required String cardId,
  }) async {
    try {
      final response = await fundCardRemoteDataSource.fundCard(
        amount: amount,
        cardId: cardId,
      );

      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
