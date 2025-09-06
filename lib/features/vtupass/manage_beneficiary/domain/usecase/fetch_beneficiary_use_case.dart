import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/manage_beneficiary.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class FetchBeneficiaryUsecase
    implements UseCase<BeneficiaryResponse, FetchBeneficiaryParams> {
  final BeneficiaryRepositories repository;

  FetchBeneficiaryUsecase(this.repository);
  @override
  Future<Either<Failure, BeneficiaryResponse>> call(
    FetchBeneficiaryParams param,
  ) async {
    return await repository.fetchBeneficiary(param.page);
  }
}

class FetchBeneficiaryParams extends Equatable {
  final int page;

  const FetchBeneficiaryParams({this.page = 1});

  @override
  List<Object?> get props => [page];
}
