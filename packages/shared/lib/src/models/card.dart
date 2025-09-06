//  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//       "card_id": "string",
//       "card_currency": "USD",
//       "card_limit": "500000",
//       "card_brand": "Mastercard",
//       "is_active": import 'package:json_annotation/json_annotation.dart';

// true,
//       "is_delete": true,
//       "created_at": "2025-06-14T16:52:14.862Z",
//       "updated_at": "2025-06-14T16:52:14.862Z",
//       "cardholder": "3fa85f64-5717-4562-b3fc-2c963f66afa6"

// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card {
  Card({
    required this.id,
    required this.cardId,
    required this.cardholder,
    required this.cardCurrency,
    required this.cardLimit,
    required this.cardBrand,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  final String id;
  @JsonKey(name: 'card_id')
  final String cardId;
  final String cardholder;
  @JsonKey(name: 'card_currency')
  final String cardCurrency;
  @JsonKey(name: 'card_limit')
  final String cardLimit;
  @JsonKey(name: 'card_brand')
  final String cardBrand;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_delete')
  final bool isDeleted;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$CardToJson(this);

  bool get isPlatinum => cardLimit == '1000000';
}
