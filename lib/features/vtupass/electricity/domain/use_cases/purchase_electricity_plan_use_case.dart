import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class PurchaseElectricityPlanUseCase
    implements UseCase<TransactionResponse, PurchaseElectricityPlanParams> {
  final ElectricityRepository electricityRepository;

  PurchaseElectricityPlanUseCase({required this.electricityRepository});

  @override
  Future<Either<Failure, TransactionResponse>> call(
    PurchaseElectricityPlanParams param,
  ) async {
    return await electricityRepository.buyPlan(
      billersCode: param.billersCode,
      serviceID: param.serviceID,
      type: param.type,
      amount: param.amount,
      phone: param.phone,
    );
  }
}

class PurchaseElectricityPlanParams {
  final String billersCode;
  final String serviceID;
  final String type;
  final String amount;
  final String phone;

  const PurchaseElectricityPlanParams({
    required this.billersCode,
    required this.serviceID,
    required this.type,
    required this.amount,
    required this.phone,
  });
}
