import 'kyc_personal_info_step.dart';
import 'kyc_address_step.dart';
import 'kyc_selfie_step.dart';
import 'kyc_primary_document_step.dart';
import 'kyc_bvn_step.dart';

class KycSteps {
  final KycPersonalInfoStep personalInfo;
  final KycAddressStep address;
  final KycSelfieStep selfie;
  final KycPrimaryDocumentStep primaryDocument;
  final KycBvnStep bvn;

  const KycSteps({
    required this.personalInfo,
    required this.address,
    required this.selfie,
    required this.primaryDocument,
    required this.bvn,
  });

  factory KycSteps.fromJson(Map<String, dynamic> json) {
    return KycSteps(
      personalInfo: KycPersonalInfoStep.fromJson(
          json['personal_info'] as Map<String, dynamic>),
      address:
          KycAddressStep.fromJson(json['address'] as Map<String, dynamic>),
      selfie: KycSelfieStep.fromJson(json['selfie'] as Map<String, dynamic>),
      primaryDocument: KycPrimaryDocumentStep.fromJson(
          json['primary_document'] as Map<String, dynamic>),
      bvn: KycBvnStep.fromJson(json['bvn'] as Map<String, dynamic>),
    );
  }
}
