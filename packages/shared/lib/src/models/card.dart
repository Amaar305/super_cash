// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

String _stringFromJson(dynamic value) => value?.toString() ?? '';

double _doubleFromJson(dynamic value) =>
    double.tryParse(value.toString()) ?? 0.0;

bool _boolFromJson(dynamic value) {
  if (value is bool) return value;
  return value?.toString().toLowerCase() == 'true';
}

@JsonSerializable()
class Card {
  Card({
    required this.id,
    required this.displayName,
    required this.brand,
    required this.cardType,
    required this.currency,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.balance,
    required this.status,
    required this.statusDisplay,
    required this.isActive,
    required this.isFrozen,
    required this.isDeleted,
    required this.isPlatinum,
    required this.cardLimit,
    required this.providerName,
    required this.issuedAt,
    required this.createdAt,
  });
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  final String id;

  @JsonKey(name: 'display_name')
  final String displayName;

  final String brand;

  @JsonKey(name: 'card_type')
  final String cardType;

  final String currency;

  @JsonKey(fromJson: _stringFromJson)
  final String last4;

  @JsonKey(name: 'expiry_month', fromJson: _stringFromJson)
  final String expiryMonth;

  @JsonKey(name: 'expiry_year', fromJson: _stringFromJson)
  final String expiryYear;

  @JsonKey(fromJson: _doubleFromJson)
  final double balance;

  final String status;

  @JsonKey(name: 'status_display')
  final String statusDisplay;

  @JsonKey(name: 'is_active', fromJson: _boolFromJson)
  final bool isActive;

  @JsonKey(name: 'is_frozen', fromJson: _boolFromJson)
  final bool isFrozen;

  @JsonKey(name: 'is_deleted', fromJson: _boolFromJson)
  final bool isDeleted;

  @JsonKey(name: 'is_platinum', fromJson: _boolFromJson)
  final bool isPlatinum;

  @JsonKey(name: 'card_limit', fromJson: _stringFromJson)
  final String cardLimit;

  @JsonKey(name: 'provider_name')
  final String providerName;

  @JsonKey(name: 'issued_at')
  final DateTime issuedAt;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$CardToJson(this);

  String get formattedCardLimit => isPlatinum ? r'$100,000' : r'$50,000';
}
