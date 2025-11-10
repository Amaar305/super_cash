import 'dart:convert';

import 'package:super_cash/features/bonus/bonus.dart';

class BankModel extends Bank {
  const BankModel({
    required super.bankName,
    required super.bankCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bank_name': bankName,
      'bank_code': bankCode,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      bankName: _readName(map),
      bankCode: _readCode(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) {
    return BankModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  static String _readName(Map<String, dynamic> map) {
    final dynamic value = map['bank_name'] ?? map['bankName'] ?? map['name'];
    return _coerceString(value, fallbackKey: 'bank_name');
  }

  static String _readCode(Map<String, dynamic> map) {
    final dynamic value = map['bank_code'] ?? map['bankCode'] ?? map['code'];
    return _coerceString(value, fallbackKey: 'bank_code');
  }

  static String _coerceString(
    dynamic value, {
    required String fallbackKey,
  }) {
    if (value is String) {
      return value;
    }
    if (value is num || value is bool) {
      return value.toString();
    }
    throw FormatException('Missing required field: $fallbackKey');
  }
}
