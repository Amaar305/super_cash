import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class GetSelfieUseCase implements UseCase<KycSelfieResponse, NoParam> {
  final KycRepository kycRepository;
  GetSelfieUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycSelfieResponse>> call(NoParam param) =>
      kycRepository.getSelfie();
}
