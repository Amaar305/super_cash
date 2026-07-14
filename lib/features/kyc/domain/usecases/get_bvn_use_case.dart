import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class GetBvnUseCase implements UseCase<KycBvnStatusResponse, NoParam> {
  final KycRepository kycRepository;
  GetBvnUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycBvnStatusResponse>> call(NoParam param) =>
      kycRepository.getBvn();
}
