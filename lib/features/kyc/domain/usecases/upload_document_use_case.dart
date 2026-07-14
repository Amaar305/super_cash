import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class KycDocumentParams {
  final String documentType;
  final String documentNumber;
  final File image;

  const KycDocumentParams({
    required this.documentType,
    required this.documentNumber,
    required this.image,
  });
}

class UploadDocumentUseCase
    implements UseCase<KycActionResult<KycDocumentData>, KycDocumentParams> {
  final KycRepository kycRepository;
  UploadDocumentUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycActionResult<KycDocumentData>>> call(
          KycDocumentParams param) =>
      kycRepository.uploadDocument(
        documentType: param.documentType,
        documentNumber: param.documentNumber,
        image: param.image,
      );
}
