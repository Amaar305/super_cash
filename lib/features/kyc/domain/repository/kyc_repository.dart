import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';

abstract interface class KycRepository {
  /// GET /kyc/status/
  Future<Either<Failure, KycStatus>> getKycStatus();

  /// GET /kyc/personal-info/
  Future<Either<Failure, KycPersonalInfoResponse>> getPersonalInfo();

  /// PUT /kyc/personal-info/
  Future<Either<Failure, KycActionResult<KycPersonalInfoResponse>>>
      submitPersonalInfo({
    required String firstName,
    required String lastName,
    String middleName,
    required String dateOfBirth,
    String? gender,
  });

  /// GET /kyc/address/
  Future<Either<Failure, KycAddressResponse>> getAddress();

  /// PUT /kyc/address/
  Future<Either<Failure, KycActionResult<KycAddressResponse>>> submitAddress({
    String country,
    required String address,
    required String city,
    required String state,
    String postalCode,
    String houseNo,
    String lga,
  });

  /// GET /kyc/selfie/
  Future<Either<Failure, KycSelfieResponse>> getSelfie();

  /// POST /kyc/selfie/
  Future<Either<Failure, KycActionResult<KycSelfieResponse>>> uploadSelfie(
      File image);

  /// GET /kyc/documents/
  Future<Either<Failure, KycDocumentsListResponse>> getDocuments();

  /// POST /kyc/documents/
  Future<Either<Failure, KycActionResult<KycDocumentData>>> uploadDocument({
    required String documentType,
    required String documentNumber,
    required File image,
  });

  /// GET /kyc/bvn/
  Future<Either<Failure, KycBvnStatusResponse>> getBvn();

  /// POST /kyc/bvn/
  Future<Either<Failure, KycActionResult<KycBvnStatusResponse>>> submitBvn(
      String bvn);

  /// POST /cards/cardholder/register/
  Future<Either<Failure, KycCardholderResponse>> registerCardholder();
}
