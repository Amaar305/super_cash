import 'dart:convert';

import 'package:super_cash/features/referal/referal.dart';

class ReferralUserModel extends ReferralUser {
  const ReferralUserModel({
    required super.id,
    required super.referredId,
    required super.username,
    required super.rewardAmount,
    required super.rewardClaimedAt,
    required super.rewarded,
    required super.expired,
    required super.expiredAt,
    required super.active,
    required super.verified,
    required super.suspended,
    required super.eligible,
    required super.expiresInDays,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'referred': referredId,
      'username': username,
      'reward_amount': rewardAmount,
      'reward_claimed_at': rewardClaimedAt?.millisecondsSinceEpoch,
      'rewarded': rewarded,
      'is_expired': expired,
      'expired_at': expiredAt?.millisecondsSinceEpoch,
      'is_active': active,
      'is_verified': verified,
      'is_suspended': suspended,
      'is_eligible': eligible,
      'expires_in_days': expiresInDays,
    };
  }

  factory ReferralUserModel.fromMap(Map<String, dynamic> map) {
    return ReferralUserModel(
      id: map['id'] as String,
      referredId: map['referred'] as String,
      username: map['username'] as String,
      rewardAmount: map['reward_amount'] as double,
      rewardClaimedAt: map['reward_claimed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reward_claimed_at'] as int)
          : null,
      rewarded: map['rewarded'] as bool,
      expired: map['is_expired'] as bool,
      expiredAt: map['expired_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expired_at'] as int)
          : null,
      active: map['is_active'] as bool,
      verified: map['is_verified'] as bool,
      suspended: map['is_suspended'] as bool,
      eligible: map['is_eligible'] as bool,
      expiresInDays: map['expires_in_days'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferralUserModel.fromJson(String source) =>
      ReferralUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
