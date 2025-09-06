// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_transactions_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardTransactionsState _$CardTransactionsStateFromJson(
        Map<String, dynamic> json) =>
    CardTransactionsState(
      status: $enumDecode(_$CardTransactionsStatusEnumMap, json['status']),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => CardTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CardTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      isSortAsc: json['isSortAsc'] as bool,
      paginationMeta: json['paginationMeta'] == null
          ? null
          : PaginationMeta.fromJson(
              json['paginationMeta'] as Map<String, dynamic>),
      hasReachedMax: json['hasReachedMax'] as bool? ?? false,
      nextPageUrl: json['nextPageUrl'] as String?,
    );

Map<String, dynamic> _$CardTransactionsStateToJson(
        CardTransactionsState instance) =>
    <String, dynamic>{
      'status': _$CardTransactionsStatusEnumMap[instance.status]!,
      'transactions': instance.transactions,
      'data': instance.data,
      'message': instance.message,
      'paginationMeta': instance.paginationMeta,
      'hasReachedMax': instance.hasReachedMax,
      'isSortAsc': instance.isSortAsc,
      'nextPageUrl': instance.nextPageUrl,
    };

const _$CardTransactionsStatusEnumMap = {
  CardTransactionsStatus.initial: 'initial',
  CardTransactionsStatus.loading: 'loading',
  CardTransactionsStatus.success: 'success',
  CardTransactionsStatus.suspended: 'suspended',
  CardTransactionsStatus.failure: 'failure',
};
