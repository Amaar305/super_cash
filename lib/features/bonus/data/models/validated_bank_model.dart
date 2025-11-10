import 'dart:convert';

import 'package:super_cash/features/bonus/bonus.dart';

class ValidatedBankModel extends ValidatedBank {
  const ValidatedBankModel({
    required super.accountNumber,
    required super.accountName,
    required super.bankCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'account_number': accountNumber,
      'account_name': accountName,
      'bank_code': bankCode,
    };
  }

  factory ValidatedBankModel.fromMap(Map<String, dynamic> map) {
    final payload = _payload(map);

    return ValidatedBankModel(
      accountNumber: _readString(
        payload,
        const ['account_number', 'accountNumber', 'accountNo'],
        fallback: 'account_number',
      ),
      accountName: _readString(
        payload,
        const ['account_name', 'accountName', 'name'],
        fallback: 'account_name',
      ),
      bankCode: _readString(
        payload,
        const ['bank_code', 'bankCode', 'code'],
        fallback: 'bank_code',
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidatedBankModel.fromJson(String source) {
    return ValidatedBankModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  static Map<String, dynamic> _payload(Map<String, dynamic> source) {
    for (final key in const [
      'data',
      'result',
      'results',
      'payload',
      'bank',
      'bank_detail',
      'bankDetail',
      'validated_bank',
      'validatedBank',
    ]) {
      final dynamic candidate = source[key];
      if (candidate is Map<String, dynamic>) {
        return candidate;
      }
    }
    return source;
  }

  static String _readString(
    Map<String, dynamic> map,
    List<String> keys, {
    required String fallback,
  }) {
    for (final key in keys) {
      final dynamic value = map[key];
      if (value == null) continue;

      if (value is String) {
        if (value.isNotEmpty) return value;
        break;
      }

      if (value is num || value is bool) {
        return value.toString();
      }
    }

    throw FormatException('Missing required field: $fallback');
  }
}
