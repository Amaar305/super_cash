import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:fpdart/fpdart.dart';

class CreateCardRepositoriesImpl implements CreateCardRepositories {
  final CreateCardRemoteDataSource createCardRemoteDataSource;
  final ApiErrorHandler apiErrorHandle;

  CreateCardRepositoriesImpl({
    required this.createCardRemoteDataSource,
    required this.apiErrorHandle,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> createVirtualCard({
    required String pin,
    required String cardLimit,
    required String amount,
    required String cardBrand,
  }) async {
    try {
      final response = await createCardRemoteDataSource.createVirtualCard(
        pin: pin,
        cardLimit: cardLimit,
        amount: amount,
        cardBrand: cardBrand,
      );
      return right(response);
    } catch (e) {
      return left(apiErrorHandle.handleError(e));
    }
  }
}
