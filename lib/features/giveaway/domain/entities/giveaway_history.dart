import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayHistory {
  final String id;
  final String description;
  final String amount;
  final GiveawayType giveawayType;
  final Map<String, dynamic>? meta;
  final DateTime createdAt;

  const GiveawayHistory({
    required this.id,
    required this.description,
    required this.amount,
    required this.giveawayType,
    required this.meta,
    required this.createdAt,
  });

  String get network =>
      ((meta?['network'] as String?) ?? 'airtel').toUpperCase();

  AirtimeGiveawayPin get giveawayPin {
    final planId = meta?['plan_id'] as String?;
    final network = meta?['network'] as String?;
    final pin = meta?['code'] as String?;
    final loadingCode = meta?['loading_code'] as String?;
    // final code = meta?['code'] as String?;

    return AirtimeGiveawayPin(
      id: planId ?? '',
      network: network ?? '',
      amount: double.parse(amount),
      maskedPin: pin ?? '',
      status: 'claimed',
      loadingCode: loadingCode,
    );
  }

  factory GiveawayHistory.fromJson(Map<String, dynamic> json) {
    return GiveawayHistory(
      id: json['id'] as String,
      amount: json['amount'] as String,
      description: json['description'] as String,
      giveawayType: GiveawayType.fromJson(
        json['giveaway_type'] as Map<String, dynamic>,
      ),
      meta: json['meta'] as Map<String, dynamic>?,
      createdAt:
          (DateTime.tryParse(json['created_at'] as String? ?? '')?.toLocal()) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'description': description,
    'giveaway_type': giveawayType.toJson(),
    'meta': meta,
    'created_at': createdAt.toIso8601String(),
  };

  GiveawayHistory copyWith({
    String? id,
    String? description,
    String? amount,
    GiveawayType? giveawayType,
    Map<String, dynamic>? meta,
    DateTime? createdAt,
  }) {
    return GiveawayHistory(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      giveawayType: giveawayType ?? this.giveawayType,
      meta: meta ?? this.meta,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
