import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class ElectricityRepository {
  Future<Either<Failure, ElectricityPlan>> getPlans();
  Future<Either<Failure, Map>> validatePlan({
    required String billersCode,
    required String serviceID,
    required String type,
  });
  Future<Either<Failure, TransactionResponse>> buyPlan({
    required String billersCode,
    required String serviceID,
    required String type,
    required String amount,
    required String phone,
  });
}
