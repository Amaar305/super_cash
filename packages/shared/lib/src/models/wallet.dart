// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Wallet {
  const Wallet({
    required this.walletBalance,
    required this.bonus,
  });

  final String walletBalance;
  final String bonus;
  const Wallet.anonymous() : this(walletBalance: '0.0', bonus: '0');

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      walletBalance:
          double.tryParse(map['wallet_balance'] as String? ?? '')?.toString() ??
              '',
      bonus: double.tryParse(map['bonus'] as String? ?? '')?.toString() ?? '',
    );
  }

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wallet_balance': walletBalance,
      'bonus': bonus,
    };
  }

  String toJson() => json.encode(toMap());
}
