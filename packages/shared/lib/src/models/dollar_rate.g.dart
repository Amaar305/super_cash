// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dollar_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DollarRate _$DollarRateFromJson(Map<String, dynamic> json) => DollarRate(
      cardCreationFee: (json['card_creation_fee'] as num).toDouble(),
      dollarRate: (json['dollar_rate'] as num).toDouble(),
      cardTransactionFee: (json['card_transaction_fee'] as num).toDouble(),
      unloadCardFee: (json['unload_card_fee'] as num).toDouble(),
    );

Map<String, dynamic> _$DollarRateToJson(DollarRate instance) =>
    <String, dynamic>{
      'dollar_rate': instance.dollarRate,
      'card_creation_fee': instance.cardCreationFee,
      'card_transaction_fee': instance.cardTransactionFee,
      'unload_card_fee': instance.unloadCardFee,
    };
