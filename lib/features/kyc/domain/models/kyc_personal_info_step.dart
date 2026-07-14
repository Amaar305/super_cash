import 'kyc_personal_info_data.dart';

class KycPersonalInfoStep {
  final bool complete;
  final KycPersonalInfoData? data;

  const KycPersonalInfoStep({required this.complete, this.data});

  factory KycPersonalInfoStep.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    return KycPersonalInfoStep(
      complete: json['complete'] as bool? ?? false,
      data: raw != null
          ? KycPersonalInfoData.fromJson(raw as Map<String, dynamic>)
          : null,
    );
  }
}
