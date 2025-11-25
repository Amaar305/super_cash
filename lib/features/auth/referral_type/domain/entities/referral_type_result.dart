import 'package:super_cash/features/auth/referral_type/domain/entities/entities.dart';

class ReferralTypeResult {
  final bool enabled;
  final List<ReferralCampaign> campaigns;

  const ReferralTypeResult({required this.enabled, required this.campaigns});

  factory ReferralTypeResult.fromJson(Map<String, dynamic> json) {
    final campaignList = json['campaigns'] as List<dynamic>? ?? const [];

    return ReferralTypeResult(
      enabled: json['enabled'] as bool? ?? false,
      campaigns: List<ReferralCampaign>.generate(
        campaignList.length,
        (index) => ReferralCampaign.fromJson(
          campaignList[index] as Map<String, dynamic>,
        ),
        growable: false,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'campaigns': campaigns
          .map((campaign) => campaign.toJson())
          .toList(growable: false),
    };
  }
}
