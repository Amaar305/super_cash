import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/manage_beneficiary.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBeneficiaryUseCase
    implements UseCase<Beneficiary, UpdateBeneficiaryParams> {
  final BeneficiaryRepositories repository;

  UpdateBeneficiaryUseCase(this.repository);

  @override
  Future<Either<Failure, Beneficiary>> call(
    UpdateBeneficiaryParams param,
  ) async {
    return await repository.updateBeneficiary(
      id: param.id,
      name: param.name,
      phone: param.phone,
      network: param.network,
    );
  }
}

class UpdateBeneficiaryParams {
  final String id;
  final String? name;
  final String? phone;
  final String? network;

  UpdateBeneficiaryParams({
    required this.id,
    required this.name,
    required this.phone,
    required this.network,
  });
}
