// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shared/shared.dart';

class AppUser {
  final String id;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final Wallet wallet;
  final bool isVerified;
  final bool isKycVerified;
  final bool transactionPin;
  final bool isSuspended;
  final String userTier;
  final List<Account> accounts;
  final String? notification;
  final List<ImageSlider> imageSliders;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phone_number': phone,
      'first_name': firstName,
      'last_name': lastName,
      'wallet': wallet.toMap(),
      'is_verified': isVerified,
      'is_kyc_verified': isKycVerified,
      'transactionPin': transactionPin,
      'is_suspended': isSuspended,
      'notification': notification,
      'user_tier': userTier,
      'sliders': imageSliders.map((e) => e.toJson()).toList(),
      'accounts': accounts
          .map(
            (e) => e.toMap(),
          )
          .toList(),
    };
  }

  const AppUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.wallet,
    required this.isVerified,
    required this.isKycVerified,
    required this.transactionPin,
    required this.isSuspended,
    this.notification,
    this.accounts = const [],
    this.imageSliders = const [],
    this.userTier = 'one',
  });

  /// Whether the current user is anonymous.
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = AppUser(
    email: '',
    firstName: 'Anonymous',
    id: '',
    isKycVerified: false,
    isVerified: false,
    lastName: 'User',
    phone: '',
    wallet: Wallet.anonymous(),
    transactionPin: false,
    isSuspended: false,
  );
  String get fullName => '$firstName  $lastName';

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      phone: map['phone_number'] as String,
      firstName: map['first_name'] as String,
      userTier: map['user_tier'] as String? ?? 'one',
      lastName: map['last_name'] as String,
      wallet: Wallet.fromMap(map['wallet'] as Map<String, dynamic>),
      isVerified: map['is_verified'] as bool,
      isKycVerified: map['is_kyc_verified'] as bool,
      transactionPin: map['transactionPin'] as bool,
      isSuspended: map['is_suspended'] as bool,
      accounts: map['accounts'] == null
          ? []
          : List.from(
              (map['accounts'] as List<dynamic>).map<Account>(
                (x) => Account.fromMap(x as Map<String, dynamic>),
              ),
            ),
      imageSliders: map['sliders'] == null
          ? []
          : List.from(
              (map['sliders'] as List<dynamic>).map<ImageSlider>(
                (x) => ImageSlider.fromJson(x as Map<String, dynamic>),
              ),
            ),
      notification: map['notification']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  AppUser copyWith({
    String? id,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    Wallet? wallet,
    bool? isVerified,
    bool? isKycVerified,
    bool? transactionPin,
    bool? isSuspended,
    List<Account>? accounts,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      wallet: wallet ?? this.wallet,
      isVerified: isVerified ?? this.isVerified,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      transactionPin: transactionPin ?? this.transactionPin,
      isSuspended: isSuspended ?? this.isSuspended,
      accounts: accounts ?? this.accounts,
    );
  }
}
