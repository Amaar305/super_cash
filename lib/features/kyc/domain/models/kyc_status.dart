import 'kyc_steps.dart';

class KycStatus {
  final bool readyForCardRegistration;
  final KycSteps steps;
  final List<String> missingSteps;

  const KycStatus({
    required this.readyForCardRegistration,
    required this.steps,
    required this.missingSteps,
  });

  factory KycStatus.fromJson(Map<String, dynamic> json) {
    return KycStatus(
      readyForCardRegistration:
          json['ready_for_card_registration'] as bool? ?? false,
      steps: KycSteps.fromJson(json['steps'] as Map<String, dynamic>),
      missingSteps: List<String>.from(json['missing_steps'] as List? ?? []),
    );
  }
}
