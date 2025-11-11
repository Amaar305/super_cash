class ReferralTypeEnrolResult {
  final String compainName;
  final String referralCode;

  const ReferralTypeEnrolResult({
    required this.compainName,
    required this.referralCode,
  });

  factory ReferralTypeEnrolResult.fromJson(Map<String, dynamic> json) {
    return ReferralTypeEnrolResult(
      compainName: json['campaign'] as String,
      referralCode: json['referral_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'campaign': compainName, 'referral_code': referralCode};
  }
}
