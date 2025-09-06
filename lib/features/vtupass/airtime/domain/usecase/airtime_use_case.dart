import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import '../repository/repository.dart';

class AirtimeUsecase implements UseCase<TransactionResponse, AirtimeParam> {
  final AirtimeRepository repository;

  AirtimeUsecase({required this.repository});
  @override
  Future<Either<Failure, TransactionResponse>> call(AirtimeParam param) async {
    return await repository.buyAirtime(
      mobileNumber: param.mobileNumber,
      amount: param.amount,
      network: param.network,
    );
  }
}

class AirtimeParam {
  final String mobileNumber;
  final String amount;
  final String network;

  AirtimeParam({
    required this.mobileNumber,
    required this.amount,
    required this.network,
  });
}
