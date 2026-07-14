import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class KycPersonalInfoParams {
  final String firstName;
  final String lastName;
  final String middleName;
  final String dateOfBirth;
  final String? gender;

  const KycPersonalInfoParams({
    required this.firstName,
    required this.lastName,
    this.middleName = '',
    required this.dateOfBirth,
    this.gender,
  });
}

class SubmitPersonalInfoUseCase
    implements
        UseCase<KycActionResult<KycPersonalInfoResponse>, KycPersonalInfoParams> {
  final KycRepository kycRepository;
  SubmitPersonalInfoUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycActionResult<KycPersonalInfoResponse>>> call(
      KycPersonalInfoParams param) =>
      kycRepository.submitPersonalInfo(
        firstName: param.firstName,
        lastName: param.lastName,
        middleName: param.middleName,
        dateOfBirth: param.dateOfBirth,
        gender: param.gender,
      );
}
