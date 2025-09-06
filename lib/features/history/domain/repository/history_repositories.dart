import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import 'package:super_cash/core/error/failure.dart';

abstract interface class HistoryRepositories {
  Future<Either<Failure, HistoryResponse>> fetchTransactions(
    int page, {
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? transactionType,
  });
}

class HistoryResponse extends Equatable {
  final List<TransactionResponse> transactions;
  final PaginationMeta paginationMeta;

  const HistoryResponse({
    required this.transactions,
    required this.paginationMeta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactions': transactions.map((x) => x.toJson()).toList(),
      'paginationMeta': paginationMeta.toJson(),
    };
  }

  factory HistoryResponse.fromMap(Map<String, dynamic> map) {
    return HistoryResponse(
      transactions: List.from(
        (map['results'] as List<dynamic>).map<TransactionResponse>(
          (x) => TransactionResponse.fromJson(x as Map<String, dynamic>),
        ),
      ),
      paginationMeta: PaginationMeta.fromJson(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryResponse.fromJson(String source) =>
      HistoryResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [transactions, paginationMeta];
}
