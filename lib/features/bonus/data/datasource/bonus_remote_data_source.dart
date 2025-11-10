import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/features/bonus/data/models/models.dart';
import 'package:token_repository/token_repository.dart';

typedef JsonMap = Map<String, dynamic>;

abstract interface class BonusRemoteDataSource {
  Future<List<BankModel>> fetchBanks();

  Future<ValidatedBankModel> validateBankDetails({
    required String accountNumber,
    required String bankCode,
  });

  Future<JsonMap> sendMoney({
    required String accountNumber,
    required String bankCode,
    required String amount,
    required String accountName,
  });

  Future<JsonMap> withdrawBonus({required String amount});
}

class BonusRemoteDataSourceImpl implements BonusRemoteDataSource {
  BonusRemoteDataSourceImpl({required this.apiClient});

  final AuthClient apiClient;

  static const _banksPath = 'accounts/bank-list/';
  static const _validatePath = 'accounts/bank-validation/';
  static const _sendMoneyPath = 'accounts/bonus-transfer/';
  static const _withdrawPath = 'accounts/bonus-withdraw/';

  @override
  Future<List<BankModel>> fetchBanks() async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: _banksPath,
        body: jsonEncode({}),
      );

      final dynamic decoded = response.body.isEmpty
          ? null
          : jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = _messageFrom(decoded);
        throw ServerException(message);
      }

      return _parseBanks(decoded);
    } on RefreshTokenException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid response from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ValidatedBankModel> validateBankDetails({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: _validatePath,
        body: jsonEncode({
          'account_number': accountNumber,
          'bank_code': bankCode,
        }),
      );

      final decoded = _decodeToMap(response.body);

      return ValidatedBankModel.fromMap(decoded);
    } on RefreshTokenException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid response from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<JsonMap> sendMoney({
    required String accountNumber,
    required String bankCode,
    required String amount,
    required String accountName,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: _sendMoneyPath,
        body: jsonEncode({
          'account_number': accountNumber,
          'bank_code': bankCode,
          'amount': amount,
          'account_name': accountName,
        }),
      );

      final decoded = _decodeToMap(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final message = extractErrorMessage(decoded);
        throw ServerException(message);
      }

      return decoded;
    } on RefreshTokenException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid response from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<JsonMap> withdrawBonus({required String amount}) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: _withdrawPath,
        body: jsonEncode({'amount': amount}),
      );

      final decoded = _decodeToMap(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final message = extractErrorMessage(decoded);
        throw ServerException(message);
      }

      return decoded;
    } on RefreshTokenException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid response from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  JsonMap _decodeToMap(String source) {
    if (source.isEmpty) return <String, dynamic>{};

    final dynamic decoded = jsonDecode(source);
    if (decoded is JsonMap) {
      return Map<String, dynamic>.from(decoded);
    }
    if (decoded is Map) {
      return Map<String, dynamic>.from(decoded);
    }

    throw FormatException('Expected JSON object.');
  }

  String _messageFrom(dynamic decoded) {
    if (decoded is JsonMap) {
      return extractErrorMessage(decoded);
    }

    return 'Something went wrong. Try again later.';
  }

  List<BankModel> _parseBanks(dynamic decoded) {
    if (decoded == null) return const <BankModel>[];

    final Iterable<dynamic> rawList;
    if (decoded is List) {
      rawList = decoded;
    } else if (decoded is Map) {
      rawList = _extractBankPayload(decoded);
    } else {
      throw FormatException('Unexpected server response.');
    }

    final banks = <BankModel>[];
    for (final entry in rawList) {
      banks.add(BankModel.fromMap(_asMap(entry)));
    }
    return banks;
  }

  Iterable<dynamic> _extractBankPayload(Map<dynamic, dynamic> map) {
    final normalized = Map<String, dynamic>.from(map);

    const keys = ['results', 'data', 'banks', 'payload', 'items', 'list'];

    for (final key in keys) {
      final dynamic candidate = normalized[key];
      if (candidate is List) return candidate;
      if (candidate is Map) {
        final nested = candidate['banks'];
        if (nested is List) return nested;
      }
    }

    if (normalized.containsKey('bank_name') ||
        normalized.containsKey('bankName')) {
      return [normalized];
    }

    throw FormatException('Unexpected server response.');
  }

  Map<String, dynamic> _asMap(dynamic source) {
    if (source is Map<String, dynamic>) return source;
    if (source is Map) {
      return Map<String, dynamic>.from(source);
    }
    throw FormatException('Expected JSON object.');
  }
}
