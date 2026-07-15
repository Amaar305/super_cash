import 'kyc_steps.dart';

class KycStatus {
  final bool readyForCardRegistration;
  final bool isKycVerified;
  final String userTier;
  final KycSteps steps;
  final List<String> missingSteps;

  const KycStatus({
    required this.readyForCardRegistration,
    required this.isKycVerified,
    required this.userTier,
    required this.steps,
    required this.missingSteps,
  });

  factory KycStatus.fromJson(Map<String, dynamic> json) {
    return KycStatus(
      readyForCardRegistration:
          json['ready_for_card_registration'] as bool? ?? false,
      isKycVerified: json['is_kyc_verified'] as bool? ?? false,
      userTier: json['user_tier']?.toString() ?? 'one',
      steps: KycSteps.fromJson(json['steps'] as Map<String, dynamic>),
      missingSteps: List<String>.from(json['missing_steps'] as List? ?? []),
    );
  }
}
