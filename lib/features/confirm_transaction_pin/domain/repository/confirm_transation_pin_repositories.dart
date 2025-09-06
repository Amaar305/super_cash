import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../confirm_transaction_pin.dart';

abstract interface class ConfirmTransactionPinRepositories {
  Future<Either<Failure, ConfirmPin>> veriFyTransactionPin(String pin);
}
