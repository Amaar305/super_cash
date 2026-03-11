class GiveawayEligibilityResult {
  final bool isEligible;
  final String message;

  const GiveawayEligibilityResult({
    required this.isEligible,
    required this.message,
  });

  factory GiveawayEligibilityResult.fromJson(Map<String, dynamic> json) {
    return GiveawayEligibilityResult(
      isEligible: json['success'] ?? false,
      message: json['message'],
    );
  }
}
