import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class AirtimeRepository {
  Future<Either<Failure, TransactionResponse>> buyAirtime({
    required String mobileNumber,
    required String amount,
    required String network,
  });
}
