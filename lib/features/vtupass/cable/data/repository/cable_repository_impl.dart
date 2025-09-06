import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:token_repository/token_repository.dart';

import '../../cable.dart';

class CableRepositoryImpl implements CableRepository {
  final CableRemoteDataSource cableRemoteDataSource;

  CableRepositoryImpl({required this.cableRemoteDataSource});

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
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
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
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
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
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
