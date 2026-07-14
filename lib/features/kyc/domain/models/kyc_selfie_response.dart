import 'kyc_selfie_data.dart';

class KycSelfieResponse {
  final bool complete;
  final KycSelfieData? data;

  const KycSelfieResponse({required this.complete, this.data});

  factory KycSelfieResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    return KycSelfieResponse(
      complete: json['complete'] as bool? ?? false,
      data: raw != null
          ? KycSelfieData.fromJson(raw as Map<String, dynamic>)
          : null,
    );
  }
}
