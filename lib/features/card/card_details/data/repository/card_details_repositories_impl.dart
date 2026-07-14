import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../card_details.dart';

class CardDetailsRepositoriesImpl implements CardDetailsRepositories {
  final CardDetailsRemoteDataSource cardDetailsRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const CardDetailsRepositoriesImpl({
    required this.cardDetailsRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, CardDetails>> getFullCardDetails(String cardId) async {
    try {
      final response = await cardDetailsRemoteDataSource.getFullCardDetails(
        cardId,
      );

      return right(response);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, CardActionResponse>> freezeCard(
    String cardId, {
    bool unfreeze = false,
  }) async {
    try {
      if (unfreeze) {
        final response = await cardDetailsRemoteDataSource.unfreezeCard(cardId);
        return right(response);
      } else {
        final response = await cardDetailsRemoteDataSource.freezeCard(cardId);
        return right(response);
      }
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
