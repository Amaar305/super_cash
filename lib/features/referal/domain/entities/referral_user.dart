import 'package:equatable/equatable.dart';

class ReferralUser extends Equatable {
  final String id;
  final String referredId;
  final String username;
  final double rewardAmount;
  final DateTime? rewardClaimedAt;
  final bool rewarded;
  final bool expired;
  final DateTime? expiredAt;
  final bool active;
  final bool verified;
  final bool suspended;
  final bool eligible;
  final int expiresInDays;

  const ReferralUser({
    required this.id,
    required this.referredId,
    required this.username,
    required this.rewardAmount,
    required this.rewardClaimedAt,
    required this.rewarded,
    required this.expired,
    required this.expiredAt,
    required this.active,
    required this.verified,
    required this.suspended,
    required this.eligible,
    required this.expiresInDays,
  });

  @override
  List<Object?> get props => [
    id,
    referredId,
    username,
    rewardAmount,
    rewardClaimedAt,
    rewarded,
    expired,
    expiredAt,
    active,
    verified,
    suspended,
    eligible,
    expiresInDays,
  ];
}
