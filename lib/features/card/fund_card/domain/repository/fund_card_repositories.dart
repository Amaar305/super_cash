import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class FundCardRepositories {
  Future<Either<Failure, TransactionResponse>> fundCard({
    required String amount,
    required String cardId,
  });
}
