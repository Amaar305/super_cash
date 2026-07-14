import 'dart:convert';
import 'dart:io';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';

abstract interface class KycRemoteDataSource {
  Future<KycStatus> getKycStatus();

  Future<KycPersonalInfoResponse> getPersonalInfo();
  Future<KycActionResult<KycPersonalInfoResponse>> submitPersonalInfo({
    required String firstName,
    required String lastName,
    String middleName,
    required String dateOfBirth,
    String? gender,
  });

  Future<KycAddressResponse> getAddress();
  Future<KycActionResult<KycAddressResponse>> submitAddress({
    String country,
    required String address,
    required String city,
    required String state,
    String postalCode,
    String houseNo,
    String lga,
  });

  Future<KycSelfieResponse> getSelfie();
  Future<KycActionResult<KycSelfieResponse>> uploadSelfie(File image);

  Future<KycDocumentsListResponse> getDocuments();
  Future<KycActionResult<KycDocumentData>> uploadDocument({
    required String documentType,
    required String documentNumber,
    required File image,
  });

  Future<KycBvnStatusResponse> getBvn();
  Future<KycActionResult<KycBvnStatusResponse>> submitBvn(String bvn);
  Future<KycCardholderResponse> registerCardholder();
}

class KycRemoteDataSourceImpl implements KycRemoteDataSource {
  final AuthClient apiClient;

  KycRemoteDataSourceImpl({required this.apiClient});

  // ── GET /kyc/status/ ──────────────────────────────────────────────────────

  @override
  Future<KycStatus> getKycStatus() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'kyc/status/',
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycStatus.fromJson(res);
  }

  // ── GET /kyc/personal-info/ ───────────────────────────────────────────────

  @override
  Future<KycPersonalInfoResponse> getPersonalInfo() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'kyc/personal-info/',
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycPersonalInfoResponse.fromJson(res);
  }

  // ── PUT /kyc/personal-info/ ───────────────────────────────────────────────

  @override
  Future<KycActionResult<KycPersonalInfoResponse>> submitPersonalInfo({
    required String firstName,
    required String lastName,
    String middleName = '',
    required String dateOfBirth,
    String? gender,
  }) async {
    final response = await apiClient.request(
      method: 'PUT',
      path: 'kyc/personal-info/',
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        'date_of_birth': dateOfBirth,
        if (gender != null) 'gender': gender,
      }),
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycActionResult(
      message: res['message'] as String? ?? '',
      data: KycPersonalInfoResponse(
        complete: true,
        data: KycPersonalInfoData.fromJson(res['data'] as Map<String, dynamic>),
      ),
      kycStatus: KycStatus.fromJson(res['kyc_status'] as Map<String, dynamic>),
    );
  }

  // ── GET /kyc/address/ ─────────────────────────────────────────────────────

  @override
  Future<KycAddressResponse> getAddress() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'kyc/address/',
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycAddressResponse.fromJson(res);
  }

  // ── PUT /kyc/address/ ─────────────────────────────────────────────────────

  @override
  Future<KycActionResult<KycAddressResponse>> submitAddress({
    String country = 'Nigeria',
    required String address,
    required String city,
    required String state,
    String postalCode = '',
    String houseNo = '',
    String lga = '',
  }) async {
    final response = await apiClient.request(
      method: 'PUT',
      path: 'kyc/address/',
      body: jsonEncode({
        'country': country,
        'address': address,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'house_no': houseNo,
        'lga': lga,
      }),
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycActionResult(
      message: res['message'] as String? ?? '',
      data: KycAddressResponse(
        complete: true,
        data: KycAddressData.fromJson(res['data'] as Map<String, dynamic>),
      ),
      kycStatus: KycStatus.fromJson(res['kyc_status'] as Map<String, dynamic>),
    );
  }

  // ── GET /kyc/selfie/ ──────────────────────────────────────────────────────

  @override
  Future<KycSelfieResponse> getSelfie() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'kyc/selfie/',
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycSelfieResponse.fromJson(res);
  }

  // ── POST /kyc/selfie/ ─────────────────────────────────────────────────────

  @override
  Future<KycActionResult<KycSelfieResponse>> uploadSelfie(File image) async {
    final response = await apiClient.multipart(
      path: 'kyc/selfie/',
      file: image,
      fileField: 'image',
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 201) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycActionResult(
      message: res['message'] as String? ?? '',
      data: KycSelfieResponse(
        complete: true,
        data: KycSelfieData.fromJson(res['data'] as Map<String, dynamic>),
      ),
      kycStatus: KycStatus.fromJson(res['kyc_status'] as Map<String, dynamic>),
    );
  }

  // ── GET /kyc/documents/ ───────────────────────────────────────────────────

  @override
  Future<KycDocumentsListResponse> getDocuments() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'kyc/documents/',
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycDocumentsListResponse.fromJson(res);
  }

  // ── POST /kyc/documents/ ──────────────────────────────────────────────────

  @override
  Future<KycActionResult<KycDocumentData>> uploadDocument({
    required String documentType,
    required String documentNumber,
    required File image,
  }) async {
    final response = await apiClient.multipart(
      path: 'kyc/documents/',
      file: image,
      fileField: 'image',
      fields: {
        'document_type': documentType,
        'document_number': documentNumber,
      },
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycActionResult(
      message: res['message'] as String? ?? '',
      data: KycDocumentData.fromJson(res['data'] as Map<String, dynamic>),
      kycStatus: KycStatus.fromJson(res['kyc_status'] as Map<String, dynamic>),
    );
  }

  // ── GET /kyc/bvn/ ────────────────────────────────────────────────────────

  @override
  Future<KycBvnStatusResponse> getBvn() async {
    final response = await apiClient.request(method: 'GET', path: 'kyc/bvn/');
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycBvnStatusResponse.fromJson(res);
  }

  // ── POST /kyc/bvn/ ───────────────────────────────────────────────────────

  @override
  Future<KycActionResult<KycBvnStatusResponse>> submitBvn(String bvn) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'kyc/bvn/',
      body: jsonEncode({'bvn': bvn}),
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycActionResult(
      message: res['message'] as String? ?? '',
      data: KycBvnStatusResponse(complete: true, bvn: res['bvn'] as String?),
      kycStatus: KycStatus.fromJson(res['kyc_status'] as Map<String, dynamic>),
    );
  }

  @override
  Future<KycCardholderResponse> registerCardholder() async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'virtual_cards/cardholder/register/',
      body: {},
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException(extractErrorMessage(res));
    }
    return KycCardholderResponse.fromJson(res['data'] as Map<String, dynamic>);
  }
}
