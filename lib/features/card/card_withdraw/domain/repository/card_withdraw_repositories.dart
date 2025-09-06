import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class CardWithdrawRepositories {
  Future<Either<Failure, TransactionResponse>> cardWithdraw({
    required String amount,
    required String cardId,
  });
  Future<Either<Failure, Wallet>> fetchBalance();
}
