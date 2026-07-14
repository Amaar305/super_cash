String _stringFromJson(dynamic value) => value?.toString() ?? '';

bool _boolFromJson(dynamic value) {
  if (value is bool) return value;
  return value?.toString().toLowerCase() == 'true';
}

class KycCardholderResponse {
  final String id;
  final String providerName;
  final String providerSlug;
  final String providerTier;
  final bool isKycComplete;
  final bool isActive;
  final String createdAt;

  const KycCardholderResponse({
    required this.id,
    required this.providerName,
    required this.providerSlug,
    required this.providerTier,
    required this.isKycComplete,
    required this.isActive,
    required this.createdAt,
  });

  factory KycCardholderResponse.fromJson(Map<String, dynamic> json) {
    return KycCardholderResponse(
      id: _stringFromJson(json['id']),
      providerName: _stringFromJson(json['provider_name']),
      providerSlug: _stringFromJson(json['provider_slug']),
      providerTier: _stringFromJson(json['provider_tier']),
      isKycComplete: _boolFromJson(json['is_kyc_complete']),
      isActive: _boolFromJson(json['is_active']),
      createdAt: _stringFromJson(json['created_at']),
    );
  }
}
