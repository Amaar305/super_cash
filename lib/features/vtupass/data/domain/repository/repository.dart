import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class DataRepository {
  Future<Either<Failure, DataPlanResponse>> fetchPlans({
    required String network,
  });

  Future<Either<Failure, TransactionResponse>> buyDataPlan({
    required String network,
    required String planId,
    required String phoneNumber,
  });
}
