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
  final Tokens? tokens;

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
      'user_tier': userTier,
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
    required this.tokens,
    this.accounts = const [],
    this.userTier = 'one',
  });

  /// Whether the current user is anonymous.
  bool get isAnonymous => id == 'none';

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = AppUser(
    email: '',
    firstName: 'Anonymous',
    id: 'none',
    isKycVerified: false,
    isVerified: false,
    lastName: 'User',
    phone: '',
    wallet: Wallet.anonymous(),
    transactionPin: false,
    isSuspended: false,
    tokens: null,
  );
  String get fullName => '$firstName  $lastName';
  factory AppUser.fromMap(Map<String, dynamic> map) {
    final user = map.containsKey('user')
        ? (map['user'] as Map?)?.cast<String, dynamic>() ?? {}
        : map;

    final accountsList = (user['accounts'] as List?)
            ?.whereType<Map<String, dynamic>>() // only keep map items
            .map((e) => e.cast<String, dynamic>())
            .toList() ??
        <Map<String, dynamic>>[];

    return AppUser(
      id: user['id']?.toString() ?? '',
      email: user['email']?.toString() ?? '',
      phone: user['phone_number']?.toString() ?? '',
      firstName: user['first_name']?.toString() ?? '',
      lastName: user['last_name']?.toString() ?? '',
      userTier: user['user_tier']?.toString() ?? 'one',
      wallet: Wallet.fromMap(
        (user['wallet'] as Map?)?.cast<String, dynamic>() ?? const {},
      ),
      isVerified: user['is_verified'] == true,
      isKycVerified: user['is_kyc_verified'] == true,
      transactionPin: user['transactionPin'] == true,
      isSuspended: user['is_suspended'] == true,
      tokens: (map['tokens'] is Map)
          ? Tokens.fromJson((map['tokens'] as Map).cast<String, dynamic>())
          : null,
      accounts: accountsList.map(Account.fromMap).toList(),
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
    Tokens? tokens,
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
      tokens: tokens ?? this.tokens,
    );
  }
}

class Tokens {
  const Tokens({
    required this.access,
    required this.refresh,
  });

  final String access;
  final String refresh;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json['access'] as String,
        refresh: json['refresh'] as String,
      );

  Map<String, dynamic> toJson() => {
        'access': access,
        'refresh': refresh,
      };
}
