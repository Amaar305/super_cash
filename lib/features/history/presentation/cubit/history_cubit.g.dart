// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryState _$HistoryStateFromJson(Map<String, dynamic> json) => HistoryState(
      message: json['message'] as String,
      status: $enumDecode(_$HistoryStatusEnumMap, json['status']),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasReachedMax: json['hasReachedMax'] as bool? ?? false,
      paginationMeta: json['paginationMeta'] == null
          ? null
          : PaginationMeta.fromJson(
              json['paginationMeta'] as Map<String, dynamic>),
      currentPage: (json['currentPage'] as num).toInt(),
      nextPageUrl: json['nextPageUrl'] as String?,
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      transactionStatus: $enumDecodeNullable(
          _$TransactionStatusEnumMap, json['transactionStatus']),
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
    );

Map<String, dynamic> _$HistoryStateToJson(HistoryState instance) =>
    <String, dynamic>{
      'status': _$HistoryStatusEnumMap[instance.status]!,
      'transactions': instance.transactions,
      'data': instance.data,
      'message': instance.message,
      'paginationMeta': instance.paginationMeta,
      'hasReachedMax': instance.hasReachedMax,
      'currentPage': instance.currentPage,
      'nextPageUrl': instance.nextPageUrl,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'transactionStatus':
          _$TransactionStatusEnumMap[instance.transactionStatus],
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
    };

const _$HistoryStatusEnumMap = {
  HistoryStatus.initial: 'initial',
  HistoryStatus.loading: 'loading',
  HistoryStatus.success: 'success',
  HistoryStatus.failure: 'failure',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.success: 'success',
  TransactionStatus.successful: 'successful',
  TransactionStatus.failed: 'failed',
  TransactionStatus.fail: 'fail',
  TransactionStatus.refund: 'refund',
  TransactionStatus.reversal: 'reversal',
  TransactionStatus.processing: 'processing',
};

const _$TransactionTypeEnumMap = {
  TransactionType.data: 'data',
  TransactionType.card: 'card',
  TransactionType.cardholder: 'cardholder',
  TransactionType.credit: 'credit',
  TransactionType.debit: 'debit',
  TransactionType.cardfunding: 'cardfunding',
  TransactionType.cable: 'cable',
  TransactionType.electricity: 'electricity',
  TransactionType.walletfunding: 'walletfunding',
  TransactionType.airtime: 'airtime',
  TransactionType.palmpay: 'palmpay',
  TransactionType.others: 'others',
};
