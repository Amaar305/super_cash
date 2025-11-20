import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../change_card_pin.dart';

class ChangeCardPinRepositoriesImpl implements ChangeCardPinRepositories {
  final ChangeCardPinRemoteDataSource changeCardPinRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

const  ChangeCardPinRepositoriesImpl({
    required this.changeCardPinRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> changeCardPin({
    required String pin,
    required String cardId,
  }) async {
    try {
      final response = await changeCardPinRemoteDataSource.changeCardPin(
        pin: pin,
        cardId: cardId,
      );

      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
