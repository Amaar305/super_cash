import 'kyc_personal_info_data.dart';

class KycPersonalInfoResponse {
  final bool complete;
  final KycPersonalInfoData? data;

  const KycPersonalInfoResponse({required this.complete, this.data});

  factory KycPersonalInfoResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    return KycPersonalInfoResponse(
      complete: json['complete'] as bool? ?? false,
      data: raw != null
          ? KycPersonalInfoData.fromJson(raw as Map<String, dynamic>)
          : null,
    );
  }
}
