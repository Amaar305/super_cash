import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayWinner {
  final String id;
  final String winner;
  final String amount;
  final DateTime createdAt;
  final GiveawayType type;

  const GiveawayWinner({
    required this.id,
    required this.winner,
    required this.amount,
    required this.createdAt,
    required this.type,
  });

  String get fixedAmount => (double.tryParse(amount) ?? 0.0).toStringAsFixed(0);

  factory GiveawayWinner.fromJson(Map<String, dynamic> json) {
    return GiveawayWinner(
      id: json['id'],
      winner: json['winner'],
      amount: json['amount'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      type: GiveawayType.fromJson(json['giveaway_type']),
    );
  }
}
