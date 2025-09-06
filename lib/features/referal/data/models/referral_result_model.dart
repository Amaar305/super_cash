import 'dart:convert';

import '../../domain/entities/referral_result.dart';

class ReferralResultModel extends ReferralResult {
  const ReferralResultModel({
    required super.claimed,
    required super.failed,
    required super.totalRewarded,
    required super.claimedCount,
  });

  @override
  List<Object?> get props => [claimed, failed, totalRewarded, claimedCount];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'claimed': claimed,
      'failed': failed,
      'total_awarded': totalRewarded,
      'claimed_count': claimedCount,
    };
  }

  factory ReferralResultModel.fromMap(Map<String, dynamic> map) {
    return ReferralResultModel(
      claimed: List<Map<String, dynamic>>.from(
        (map['claimed'] as List<dynamic>).map<Map<String, dynamic>>((x) => x),
      ),
      failed: List<Map<String, dynamic>>.from(
        (map['failed'] as List<dynamic>).map<Map<String, dynamic>>((x) => x),
      ),
      totalRewarded: map['total_awarded'] as double,
      claimedCount: map['claimed_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferralResultModel.fromJson(String source) =>
      ReferralResultModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
