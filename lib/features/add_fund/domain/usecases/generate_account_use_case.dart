import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/add_fund/domain/repository/add_fund_repository.dart';
import 'package:fpdart/fpdart.dart';

class GenerateAccountUseCase implements UseCase<String, GenerateAccountParams> {
  final AddFundRepository addFundRepository;

  GenerateAccountUseCase({required this.addFundRepository});

  @override
  Future<Either<Failure, String>> call(GenerateAccountParams params) {
    return addFundRepository.generateAccount(bvn: params.bvn);
  }
}

class GenerateAccountParams {
  final String bvn;

  GenerateAccountParams({required this.bvn});
}
