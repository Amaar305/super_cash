import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../cable.dart';

class CableRepositoryImpl implements CableRepository {
  final CableRemoteDataSource cableRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const CableRepositoryImpl({
    required this.cableRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, Map>> buyCable({
    required String provider,
    required String variationCode,
    required String smartcardNumber,
    required String phone,
  }) async {
    try {
      final res = await cableRemoteDataSource.buyCable(
        provider: provider,
        variationCode: variationCode,
        smartcardNumber: smartcardNumber,
        phone: phone,
      );
      return right(res);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, Map>> fetchCableResponse({
    required String provider,
  }) async {
    try {
      final res = await cableRemoteDataSource.fetchCableResponse(
        provider: provider,
      );
      return right(res);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, Map>> validateCable({
    required String provider,
    required String smartcardNumber,
  }) async {
    try {
      final res = await cableRemoteDataSource.validateCable(
        provider: provider,
        smartcardNumber: smartcardNumber,
      );
      return right(res);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
