import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import 'package:token_repository/token_repository.dart';

import '../../../vtupass.dart';

class ElectricityRepositoryImpl implements ElectricityRepository {
  final ElectricityRemoteDataSource electricityRemoteDataSource;

  ElectricityRepositoryImpl({required this.electricityRemoteDataSource});

  @override
  Future<Either<Failure, TransactionResponse>> buyPlan({
    required String billersCode,
    required String serviceID,
    required String type,
    required String amount,
    required String phone,
  }) async {
    try {
      final response = await electricityRemoteDataSource.buyPlan(
        billersCode: billersCode,
        serviceID: serviceID,
        type: type,
        amount: amount,
        phone: phone,
      );

      return right(response);
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ElectricityPlan>> getPlans() async {
    try {
      final response = await electricityRemoteDataSource.getPlans();

      return right(response);
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map>> validatePlan({
    required String billersCode,
    required String serviceID,
    required String type,
  }) async {
    try {
      final response = await electricityRemoteDataSource.validatePlan(
        billersCode: billersCode,
        serviceID: serviceID,
        type: type,
      );

      return right(response);
    } on RefreshTokenException catch (e) {
      return left(RefreshTokenFailure(e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
