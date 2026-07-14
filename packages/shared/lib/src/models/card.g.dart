// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      id: json['id'] as String,
      displayName: json['display_name'] as String,
      brand: json['brand'] as String,
      cardType: json['card_type'] as String,
      currency: json['currency'] as String,
      last4: _stringFromJson(json['last4']),
      expiryMonth: _stringFromJson(json['expiry_month']),
      expiryYear: _stringFromJson(json['expiry_year']),
      balance: _doubleFromJson(json['balance']),
      status: json['status'] as String,
      statusDisplay: json['status_display'] as String,
      isActive: _boolFromJson(json['is_active']),
      isFrozen: _boolFromJson(json['is_frozen']),
      isDeleted: _boolFromJson(json['is_deleted']),
      isPlatinum: _boolFromJson(json['is_platinum']),
      cardLimit: _stringFromJson(json['card_limit']),
      providerName: json['provider_name'] as String,
      issuedAt: DateTime.parse(json['issued_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'brand': instance.brand,
      'card_type': instance.cardType,
      'currency': instance.currency,
      'last4': instance.last4,
      'expiry_month': instance.expiryMonth,
      'expiry_year': instance.expiryYear,
      'balance': instance.balance,
      'status': instance.status,
      'status_display': instance.statusDisplay,
      'is_active': instance.isActive,
      'is_frozen': instance.isFrozen,
      'is_deleted': instance.isDeleted,
      'is_platinum': instance.isPlatinum,
      'card_limit': instance.cardLimit,
      'provider_name': instance.providerName,
      'issued_at': instance.issuedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
