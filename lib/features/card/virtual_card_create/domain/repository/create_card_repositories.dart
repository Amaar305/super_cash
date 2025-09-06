import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CreateCardRepositories {
  Future<Either<Failure, Map<String, dynamic>>> createVirtualCard({
    required String pin,
    required String cardLimit,
    required String amount,
    required String cardBrand,
  });
}
