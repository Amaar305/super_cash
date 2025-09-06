// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class Account {
  Account({
    required this.accountType,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    this.bvn,
  });

  final String? bvn;
  final String accountType;
  final String accountName;
  final String accountNumber;
  final String bankName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bvn': bvn,
      'account_type': accountType,
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_name': bankName,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      bvn: map['bvn'] != null ? map['bvn'] as String : null,
      accountType: map['account_type'] as String,
      accountName: map['account_name'] as String,
      accountNumber: map['account_number'] as String,
      bankName: (map['bank_name'] as String?) ?? 'Unknown Bank',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);
}
