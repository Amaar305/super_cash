class CashGiveawayItem {
  final String id;
  final String cashName;
  final String cashAmount;
  final String description;
  final int cashQuantity;
  final int cashQuantityRemaining;
  final bool requiresBankDetails;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CashGiveawayItem({
    required this.id,
    required this.cashName,
    required this.cashAmount,
    required this.description,
    required this.cashQuantity,
    required this.cashQuantityRemaining,
    required this.requiresBankDetails,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CashGiveawayItem.fromJson(Map<String, dynamic> json) {
    return CashGiveawayItem(
      id: json['id'],
      cashName: json['cash_name'] as String,
      cashAmount: json['cash_amount'] as String,
      description: json['description'],
      cashQuantity: (json['cash_quantity'] as num).toInt(),
      cashQuantityRemaining: (json['cash_quantity_remaining'] as num).toInt(),
      requiresBankDetails: json['requires_bank_details'] as bool,
      isAvailable: json['is_available'] as bool,
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      updatedAt: DateTime.parse(json['updated_at']).toLocal(),
    );
  }
}
