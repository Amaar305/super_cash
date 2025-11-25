import 'dart:convert';

import 'package:super_cash/features/auth/referral_type/referral_type.dart';

import '../../domain/entities/referral_result.dart';

class ReferralResultModel extends ReferralResult {
  const ReferralResultModel({
    required super.campaign,
    required super.referraalTotal,
    required super.enrolled,
    required super.invitees,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'campaign': campaign.toJson(),
      'totals': ReferraalTotalModel(
        invited: referraalTotal.invited,
        verified: referraalTotal.verified,
        active: referraalTotal.active,
        rewardsClaimed: referraalTotal.rewardsClaimed,
        totalCollectedAmount: referraalTotal.totalCollectedAmount,
      ).toMap(),
      'enrolled': enrolled,
      'invitees': invitees.map((invitee) => invitee.toMap()).toList(),
    };
  }

  factory ReferralResultModel.fromMap(Map<String, dynamic> map) {
    final inviteesList = map['invitees'] as List<dynamic>? ?? const [];

    return ReferralResultModel(
      campaign: ReferralCampaign.fromJson(
        (map['campaign'] as Map<String, dynamic>? ?? const {}),
      ),
      referraalTotal: ReferraalTotalModel.fromMap(
        map['totals'] as Map<String, dynamic>? ?? const {},
      ),
      enrolled: map['enrolled'] as bool? ?? false,
      invitees: inviteesList
          .map(
            (e) => ReferralInvitee.fromMap(e as Map<String, dynamic>),
          )
          .toList(growable: false),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferralResultModel.fromJson(String source) =>
      ReferralResultModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ReferraalTotalModel extends ReferraalTotal {
  const ReferraalTotalModel({
    required super.invited,
    required super.verified,
    required super.active,
    required super.rewardsClaimed,
    required super.totalCollectedAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invited': invited,
      'verified': verified,
      'active': active,
      'rewards_claimed': rewardsClaimed,
      'total_collected_amount': totalCollectedAmount,
    };
  }

  factory ReferraalTotalModel.fromMap(Map<String, dynamic> map) {
    return ReferraalTotalModel(
      invited: (map['invited'] as num?)?.toInt() ?? 0,
      verified: (map['verified'] as num?)?.toInt() ?? 0,
      active: (map['active'] as num?)?.toInt() ?? 0,
      rewardsClaimed: map['rewards_claimed']?.toString() ?? '0',
      totalCollectedAmount: map['total_collected_amount']?.toString() ?? '0',
    );
  }
}
