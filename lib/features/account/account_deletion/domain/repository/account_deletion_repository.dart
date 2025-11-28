import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';

abstract interface class AccountDeletionRepository {
  Future<Either<Failure, void>> accountDeletionRequested({required String reason});
}