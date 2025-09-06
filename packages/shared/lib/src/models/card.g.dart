// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      id: json['id'] as String,
      cardId: json['card_id'] as String,
      cardholder: json['cardholder'] as String,
      cardCurrency: json['card_currency'] as String,
      cardLimit: json['card_limit'] as String,
      cardBrand: json['card_brand'] as String,
      isActive: json['is_active'] as bool,
      isDeleted: json['is_delete'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'card_id': instance.cardId,
      'cardholder': instance.cardholder,
      'card_currency': instance.cardCurrency,
      'card_limit': instance.cardLimit,
      'card_brand': instance.cardBrand,
      'is_active': instance.isActive,
      'is_delete': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
