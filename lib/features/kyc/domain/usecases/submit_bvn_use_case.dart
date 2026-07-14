import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class SubmitBvnUseCase
    implements UseCase<KycActionResult<KycBvnStatusResponse>, String> {
  final KycRepository kycRepository;
  SubmitBvnUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycActionResult<KycBvnStatusResponse>>> call(
          String param) =>
      kycRepository.submitBvn(param);
}
