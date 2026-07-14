import 'kyc_address_data.dart';

class KycAddressResponse {
  final bool complete;
  final KycAddressData? data;

  const KycAddressResponse({required this.complete, this.data});

  factory KycAddressResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    return KycAddressResponse(
      complete: json['complete'] as bool? ?? false,
      data: raw != null
          ? KycAddressData.fromJson(raw as Map<String, dynamic>)
          : null,
    );
  }
}
