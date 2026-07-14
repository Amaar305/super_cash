import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class UploadSelfieUseCase
    implements UseCase<KycActionResult<KycSelfieResponse>, File> {
  final KycRepository kycRepository;
  UploadSelfieUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycActionResult<KycSelfieResponse>>> call(
          File param) =>
      kycRepository.uploadSelfie(param);
}
