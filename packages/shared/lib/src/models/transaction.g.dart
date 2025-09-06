// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      description: json['description'] as String,
      transactionType: $enumDecodeNullable(
            _$TransactionTypeEnumMap,
            json['transaction_type'],
          ) ??
          TransactionType.others,
      transactionStatus: $enumDecodeNullable(
            _$TransactionStatusEnumMap,
            json['transaction_status'],
          ) ??
          TransactionStatus.pending,
      amount: json['amount'] as String,
      balanceBefore: json['balance_before'] as String,
      balanceAfter: json['balance_after'] as String,
      reference: json['reference'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TransactionResponseToJson(
  TransactionResponse instance,
) =>
    <String, dynamic>{
      'description': instance.description,
      'transaction_type': _$TransactionTypeEnumMap[instance.transactionType],
      'transaction_status':
          _$TransactionStatusEnumMap[instance.transactionStatus],
      'amount': instance.amount,
      'balance_before': instance.balanceBefore,
      'balance_after': instance.balanceAfter,
      'reference': instance.reference,
      'created_at': instance.createdAt.toIso8601String(),
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
