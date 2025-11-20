import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';


import '../../../vtupass.dart';

class ElectricityRepositoryImpl implements ElectricityRepository {
  final ElectricityRemoteDataSource electricityRemoteDataSource;
    final ApiErrorHandler apiErrorHandler;

 const ElectricityRepositoryImpl({required this.electricityRemoteDataSource, required this.apiErrorHandler});



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
    }catch(error){
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, ElectricityPlan>> getPlans() async {
    try {
      final response = await electricityRemoteDataSource.getPlans();

      return right(response);
    }catch(error){
      return left(apiErrorHandler.handleError(error));
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
    }catch(error){
      return left(apiErrorHandler.handleError(error));
    }
  }
}
