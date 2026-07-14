// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'card_fee_settings.g.dart';

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

/// USD/NGN exchange rate and all card fee/limit settings, sourced from the
/// backend's `CardSetting` model (virtual_cards app) via
/// `GET virtual_cards/settings/`. Replaces the old `DollarRate` model, which
/// sourced from the legacy `card` app's `dollar-rate/` endpoint.
@JsonSerializable(createFactory: false)
class CardFeeSettings {
  CardFeeSettings({
    required this.usdToNgnRate,
    required this.cardCreationFeeUsd,
    required this.cardCreationFeeNgn,
    required this.fundingFeePercent,
    required this.fundingFeeFixedUsd,
    required this.fundingFeeFixedNgn,
    required this.withdrawalFeePercent,
    required this.withdrawalFeeFixedUsd,
    required this.withdrawalFeeFixedNgn,
    required this.minFundingUsd,
    required this.maxFundingUsd,
    required this.minFundingNgn,
    required this.maxFundingNgn,
    required this.minWithdrawalUsd,
    required this.maxWithdrawalUsd,
    required this.minWithdrawalNgn,
    required this.maxWithdrawalNgn,
  });

  factory CardFeeSettings.fromJson(Map<String, dynamic> json) =>
      CardFeeSettings(
        usdToNgnRate: _parseDouble(json['usd_to_ngn_rate']),
        cardCreationFeeUsd: _parseDouble(json['card_creation_fee_usd']),
        cardCreationFeeNgn: _parseDouble(json['card_creation_fee_ngn']),
        fundingFeePercent: _parseDouble(json['funding_fee_percent']),
        fundingFeeFixedUsd: _parseDouble(json['funding_fee_fixed_usd']),
        fundingFeeFixedNgn: _parseDouble(json['funding_fee_fixed_ngn']),
        withdrawalFeePercent: _parseDouble(json['withdrawal_fee_percent']),
        withdrawalFeeFixedUsd: _parseDouble(json['withdrawal_fee_fixed_usd']),
        withdrawalFeeFixedNgn: _parseDouble(json['withdrawal_fee_fixed_ngn']),
        minFundingUsd: _parseDouble(json['min_funding_usd']),
        maxFundingUsd: _parseDouble(json['max_funding_usd']),
        minFundingNgn: _parseDouble(json['min_funding_ngn']),
        maxFundingNgn: _parseDouble(json['max_funding_ngn']),
        minWithdrawalUsd: _parseDouble(json['min_withdrawal_usd']),
        maxWithdrawalUsd: _parseDouble(json['max_withdrawal_usd']),
        minWithdrawalNgn: _parseDouble(json['min_withdrawal_ngn']),
        maxWithdrawalNgn: _parseDouble(json['max_withdrawal_ngn']),
      );

  @JsonKey(name: 'usd_to_ngn_rate')
  final double usdToNgnRate;

  @JsonKey(name: 'card_creation_fee_usd')
  final double cardCreationFeeUsd;
  @JsonKey(name: 'card_creation_fee_ngn')
  final double cardCreationFeeNgn;

  @JsonKey(name: 'funding_fee_percent')
  final double fundingFeePercent;
  @JsonKey(name: 'funding_fee_fixed_usd')
  final double fundingFeeFixedUsd;
  @JsonKey(name: 'funding_fee_fixed_ngn')
  final double fundingFeeFixedNgn;

  @JsonKey(name: 'withdrawal_fee_percent')
  final double withdrawalFeePercent;
  @JsonKey(name: 'withdrawal_fee_fixed_usd')
  final double withdrawalFeeFixedUsd;
  @JsonKey(name: 'withdrawal_fee_fixed_ngn')
  final double withdrawalFeeFixedNgn;

  @JsonKey(name: 'min_funding_usd')
  final double minFundingUsd;
  @JsonKey(name: 'max_funding_usd')
  final double maxFundingUsd;
  @JsonKey(name: 'min_funding_ngn')
  final double minFundingNgn;
  @JsonKey(name: 'max_funding_ngn')
  final double maxFundingNgn;

  @JsonKey(name: 'min_withdrawal_usd')
  final double minWithdrawalUsd;
  @JsonKey(name: 'max_withdrawal_usd')
  final double maxWithdrawalUsd;
  @JsonKey(name: 'min_withdrawal_ngn')
  final double minWithdrawalNgn;
  @JsonKey(name: 'max_withdrawal_ngn')
  final double maxWithdrawalNgn;

  Map<String, dynamic> toJson() => _$CardFeeSettingsToJson(this);
}
