class DirectAirtimeModel {
  final String id;
  final String networkId;
  final String network;
  final String airtimeName;
  final String airtimeDescription;
  final String amount;
  final int amountQuantity;
  final int amountQuantityRemaining;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get fixedAmount => (double.tryParse(amount) ?? 0.0).toStringAsFixed(0);

  const DirectAirtimeModel({
    required this.id,
    required this.networkId,
    required this.network,
    required this.airtimeName,
    required this.airtimeDescription,
    required this.amount,
    required this.amountQuantity,
    required this.amountQuantityRemaining,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DirectAirtimeModel.fromJson(Map<String, dynamic> json) {
    return DirectAirtimeModel(
      id: json['id'],
      networkId: json['network_id'],
      network: json['network'],
      airtimeName: json['airtime_name'],
      airtimeDescription: json['airtime_description'],
      amount: json['amount'],
      amountQuantity: (json['airtime_quantity'] as num).toInt(),
      amountQuantityRemaining: (json['airtime_quantity_remaining'] as num)
          .toInt(),
      isAvailable: json['is_available'] as bool,
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      updatedAt: DateTime.parse(json['updated_at']).toLocal(),
    );
  }
}
