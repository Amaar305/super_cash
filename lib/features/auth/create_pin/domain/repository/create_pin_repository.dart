import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CreatePinRepository {
  Future<Either<Failure, Map>> createTransactionPin(String pin);
}
