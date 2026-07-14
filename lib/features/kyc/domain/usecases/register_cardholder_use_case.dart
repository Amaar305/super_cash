import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class RegisterCardholderUseCase
    implements UseCase<KycCardholderResponse, NoParam> {
  final KycRepository kycRepository;
  RegisterCardholderUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycCardholderResponse>> call(NoParam param) =>
      kycRepository.registerCardholder();
}
