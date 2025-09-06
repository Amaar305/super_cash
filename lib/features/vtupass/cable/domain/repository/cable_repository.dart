import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CableRepository {
  Future<Either<Failure, Map>> fetchCableResponse({required String provider});
  Future<Either<Failure, Map>> validateCable({
    required String provider,
    required String smartcardNumber,
  });
  Future<Either<Failure, Map>> buyCable({
    required String provider,
    required String variationCode,
    required String smartcardNumber,
    required String phone,
  });
}
