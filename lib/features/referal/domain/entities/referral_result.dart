

import 'package:equatable/equatable.dart';

class ReferralResult extends Equatable {
  final List<Map<String, dynamic>> claimed;
  final List<Map<String, dynamic>> failed;
  final double totalRewarded;
  final int claimedCount;

  const ReferralResult({
    required this.claimed,
    required this.failed,
    required this.totalRewarded,
    required this.claimedCount,
  });

  @override
  List<Object?> get props => [claimed, failed, totalRewarded, claimedCount];


 
}
