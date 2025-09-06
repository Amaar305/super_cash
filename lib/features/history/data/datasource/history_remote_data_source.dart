import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:intl/intl.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

import '../../history.dart';

abstract interface class HistoryRemoteDataSource {
  Future<HistoryResponse> fetchTransactions(
    int page, {
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? transactionType,
  });
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final AuthClient apiClient;

  HistoryRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<HistoryResponse> fetchTransactions(
    int page, {
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? transactionType,
  }) async {
    try {
      final path = buildTransactionQueryPath(
        page: page,
        start: start,
        end: end,
        status: status,
        transactionType: transactionType,
      );

      final response = await apiClient.request(
        method: 'GET',
        path: path,
        body: jsonEncode({}),
      );

      if (response.statusCode != 200) {
        throw ServerException('Something went wrong. Try again later');
      }
      Map<String, dynamic> res = jsonDecode(response.body);
      return HistoryResponse.fromMap(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  String buildTransactionQueryPath({
    required int page,
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? transactionType,
  }) {
    final query = <String, String>{
      'page': page.toString(),
      if (start != null) 'start_date': DateFormat('yyyy-MM-dd').format(start),
      if (end != null) 'end_date': DateFormat('yyyy-MM-dd').format(end),
      if (status != null) 'status': status.name,
      if (transactionType != null) 'type': transactionType.name,
    };

    final queryString = query.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
    logI('transaction/app-transactions/?$queryString');
    return 'transaction/app-transactions/?$queryString';
  }
}
