// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dollar_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DollarRate _$DollarRateFromJson(Map<String, dynamic> json) => DollarRate(
      cardCreationFee: double.parse(json['card_creation_fee'] as String),
      dollarRate: double.parse(json['dollar_rate'] as String),
      cardTransactionFee: double.parse(json['card_transaction_fee'] as String),
      unloadCardFee: double.parse(json['unload_card_fee'] as String),
    );

Map<String, dynamic> _$DollarRateToJson(DollarRate instance) =>
    <String, dynamic>{
      'dollar_rate': instance.dollarRate.toString(),
      'card_creation_fee': instance.cardCreationFee.toString(),
      'card_transaction_fee': instance.cardTransactionFee.toString(),
      'unload_card_fee': instance.unloadCardFee.toString(),
    };
