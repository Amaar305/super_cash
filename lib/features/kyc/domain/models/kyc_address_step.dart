import 'kyc_address_data.dart';

class KycAddressStep {
  final bool complete;
  final List<String> missingFields;
  final KycAddressData? data;

  const KycAddressStep({
    required this.complete,
    this.missingFields = const [],
    this.data,
  });

  factory KycAddressStep.fromJson(Map<String, dynamic> json) {
    final rawMissing = json['missing_fields'];
    final missing = rawMissing != null
        ? List<String>.from(rawMissing as List)
        : <String>[];
    final raw = json['data'];
    return KycAddressStep(
      complete: json['complete'] as bool? ?? false,
      missingFields: missing,
      data: raw != null
          ? KycAddressData.fromJson(raw as Map<String, dynamic>)
          : null,
    );
  }
}
