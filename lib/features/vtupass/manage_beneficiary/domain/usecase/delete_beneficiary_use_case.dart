import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/manage_beneficiary.dart';
import 'package:fpdart/fpdart.dart';

class DeleteBeneficiaryUseCase
    implements UseCase<void, DeleteBeneficiaryParams> {
  final BeneficiaryRepositories repository;

  DeleteBeneficiaryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteBeneficiaryParams param) async {
    return await repository.deleteBeneficiary(id: param.id);
  }
}

class DeleteBeneficiaryParams {
  final String id;

  DeleteBeneficiaryParams({required this.id});
}
