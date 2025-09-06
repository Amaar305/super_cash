// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'dollar_rate.g.dart';

@JsonSerializable()
class DollarRate {
  DollarRate({
    required this.cardCreationFee,
    required this.dollarRate,
    required this.cardTransactionFee,
    required this.unloadCardFee,
  });

  factory DollarRate.fromJson(Map<String, dynamic> json) =>
      _$DollarRateFromJson(json);
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
