import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:super_cash/features/auth/referral_type/referral_type.dart';

class ReferralResult extends Equatable {
  final ReferralCampaign campaign;
  final ReferraalTotal referraalTotal;
  final bool enrolled;
  final List<ReferralInvitee> invitees;

  const ReferralResult({
    required this.campaign,
    required this.referraalTotal,
    required this.enrolled,
    required this.invitees,
  });

  @override
  List<Object?> get props => [campaign, referraalTotal, enrolled];
}

class ReferraalTotal extends Equatable {
  final int invited;
  final int verified;
  final int active;
  final String rewardsClaimed;
  final String totalCollectedAmount;

  const ReferraalTotal({
    required this.invited,
    required this.verified,
    required this.active,
    required this.rewardsClaimed,
    required this.totalCollectedAmount,
  });

  @override
  List<Object?> get props => [
    invited,
    verified,
    active,
    rewardsClaimed,
    totalCollectedAmount,
  ];
}

class ReferralInvitee {
  final String inviteId;
  final String status;
  final String? signedUpAt;
  final String? expiresAt;
  final String? firstActionAt;
  final ReferredUser? referredUser;

  ReferralInvitee({
    required this.inviteId,
    required this.status,
    this.signedUpAt,
    this.expiresAt,
    this.firstActionAt,
    this.referredUser,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'invite_id': inviteId,
      'status': status,
      'signed_up_at': signedUpAt,
      'expires_at': expiresAt,
      'first_action_at': firstActionAt,
      'referred_user': referredUser?.toMap(),
    };
  }

  // Convert to JSON
  String toJson() => json.encode(toMap());

  // Factory constructor to create instance from Map
  factory ReferralInvitee.fromMap(Map<String, dynamic> map) {
    return ReferralInvitee(
      inviteId: map['invite_id'] ?? '',
      status: map['status'] ?? '',
      signedUpAt: map['signed_up_at'],
      expiresAt: map['expires_at'],
      firstActionAt: map['first_action_at'],
      referredUser: map['referred_user'] != null
          ? ReferredUser.fromMap(map['referred_user'])
          : null,
    );
  }

  // Factory constructor to create instance from JSON
  factory ReferralInvitee.fromJson(String source) =>
      ReferralInvitee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReferralInvitee(inviteId: $inviteId, status: $status, signedUpAt: $signedUpAt, expiresAt: $expiresAt, firstActionAt: $firstActionAt, referredUser: $referredUser)';
  }
}

class ReferredUser {
  final String id;
  final String firstName;
  final String lastInitial;
  final String emailHint;
  final String phoneHint;
  final bool isVerified;
  final bool isKycActive;
  final bool isSuspended;

  ReferredUser({
    required this.id,
    required this.firstName,
    required this.lastInitial,
    required this.emailHint,
    required this.phoneHint,
    required this.isVerified,
    required this.isKycActive,
    required this.isSuspended,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_initial': lastInitial,
      'email_hint': emailHint,
      'phone_hint': phoneHint,
      'is_verified': isVerified,
      'is_kyc_verified': isKycActive,
      'is_suspended': isSuspended,
    };
  }

  // Convert to JSON
  String toJson() => json.encode(toMap());

  // Factory constructor to create instance from Map
  factory ReferredUser.fromMap(Map<String, dynamic> map) {
   
    return ReferredUser(
      id: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastInitial: map['last_initial'] ?? '',
      emailHint: map['email_hint'] ?? '',
      phoneHint: map['phone_hint'] ?? '',
      isVerified: map['is_verified'] ?? false,
      isKycActive: map['is_kyc_verified'] ?? false,
      isSuspended: map['is_suspended'] ?? false,
    );
  }

  // Factory constructor to create instance from JSON
  factory ReferredUser.fromJson(String source) =>
      ReferredUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReferredUser(id: $id, firstName: $firstName, lastInitial: $lastInitial, emailHint: $emailHint, phoneHint: $phoneHint, isVerified: $isVerified, isKycActive: $isKycActive, isSuspended: $isSuspended)';
  }
}
