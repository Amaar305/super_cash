import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/manage_beneficiary.dart';
import 'package:fpdart/fpdart.dart';

class SaveBeneficiaryUseCase
    implements UseCase<Beneficiary, SaveBeneficiaryParams> {
  final BeneficiaryRepositories repository;

  SaveBeneficiaryUseCase(this.repository);

  @override
  Future<Either<Failure, Beneficiary>> call(SaveBeneficiaryParams param) async {
    return await repository.saveBeneficiary(
      name: param.name,
      phone: param.phone,
      network: param.network,
    );
  }
}

class SaveBeneficiaryParams {
  final String name;
  final String phone;
  final String network;

  SaveBeneficiaryParams({
    required this.name,
    required this.phone,
    required this.network,
  });
}
