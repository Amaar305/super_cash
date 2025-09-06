import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../card_repo.dart';

class CardRepositoryImpl implements CardRepositories {
  final CardRemoteDataSource cardRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  CardRepositoryImpl({
    required this.cardRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, DollarRate>> getDollarRate() async {
    try {
      final result = await cardRemoteDataSource.getDollarRate();
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
