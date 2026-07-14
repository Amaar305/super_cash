import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/kyc/data/datasource/kyc_remote_data_source.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class KycRepositoryImpl implements KycRepository {
  final KycRemoteDataSource kycRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  KycRepositoryImpl({
    required this.kycRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, KycStatus>> getKycStatus() async {
    try {
      return right(await kycRemoteDataSource.getKycStatus());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycPersonalInfoResponse>> getPersonalInfo() async {
    try {
      return right(await kycRemoteDataSource.getPersonalInfo());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycActionResult<KycPersonalInfoResponse>>>
      submitPersonalInfo({
    required String firstName,
    required String lastName,
    String middleName = '',
    required String dateOfBirth,
    String? gender,
  }) async {
    try {
      return right(await kycRemoteDataSource.submitPersonalInfo(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        dateOfBirth: dateOfBirth,
        gender: gender,
      ));
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycAddressResponse>> getAddress() async {
    try {
      return right(await kycRemoteDataSource.getAddress());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycActionResult<KycAddressResponse>>> submitAddress({
    String country = 'Nigeria',
    required String address,
    required String city,
    required String state,
    String postalCode = '',
    String houseNo = '',
    String lga = '',
  }) async {
    try {
      return right(await kycRemoteDataSource.submitAddress(
        country: country,
        address: address,
        city: city,
        state: state,
        postalCode: postalCode,
        houseNo: houseNo,
        lga: lga,
      ));
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycSelfieResponse>> getSelfie() async {
    try {
      return right(await kycRemoteDataSource.getSelfie());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycActionResult<KycSelfieResponse>>> uploadSelfie(
      File image) async {
    try {
      return right(await kycRemoteDataSource.uploadSelfie(image));
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycDocumentsListResponse>> getDocuments() async {
    try {
      return right(await kycRemoteDataSource.getDocuments());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycActionResult<KycDocumentData>>> uploadDocument({
    required String documentType,
    required String documentNumber,
    required File image,
  }) async {
    try {
      return right(await kycRemoteDataSource.uploadDocument(
        documentType: documentType,
        documentNumber: documentNumber,
        image: image,
      ));
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycBvnStatusResponse>> getBvn() async {
    try {
      return right(await kycRemoteDataSource.getBvn());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycActionResult<KycBvnStatusResponse>>> submitBvn(
      String bvn) async {
    try {
      return right(await kycRemoteDataSource.submitBvn(bvn));
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, KycCardholderResponse>> registerCardholder() async {
    try {
      return right(await kycRemoteDataSource.registerCardholder());
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
