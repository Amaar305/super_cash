// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'dollar_rate.g.dart';

double _parseDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    final parsed = double.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }
  throw FormatException('Invalid double value: $value');
}

@JsonSerializable()
class DollarRate {
  DollarRate({
    required this.cardCreationFee,
    required this.dollarRate,
    required this.cardTransactionFee,
    required this.unloadCardFee,
  });

  factory DollarRate.fromJson(Map<String, dynamic> json) =>
      DollarRate(
        cardCreationFee: _parseDouble(json['card_creation_fee']),
        dollarRate: _parseDouble(json['dollar_rate']),
        cardTransactionFee: _parseDouble(json['card_transaction_fee']),
        unloadCardFee: _parseDouble(json['unload_card_fee']),
      );
  @JsonKey(name: 'dollar_rate')
  final double dollarRate;
  @JsonKey(name: 'card_creation_fee')
  final double cardCreationFee;
  @JsonKey(name: 'card_transaction_fee')
  final double cardTransactionFee;
  @JsonKey(name: 'unload_card_fee')
  final double unloadCardFee;

  Map<String, dynamic> toJson() => _$DollarRateToJson(this);
}
