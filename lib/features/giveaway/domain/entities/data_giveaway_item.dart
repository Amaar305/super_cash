class DataGiveawayItem {
  const DataGiveawayItem({
    required this.id,
    required this.dataName,
    required this.dataSize,
    required this.dataQuantity,
    required this.dataQuantityRemaining,
    required this.network,
    required this.planId,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String dataName;
  final String dataSize;
  final int dataQuantity;
  final int dataQuantityRemaining;
  final String network;
  final String planId;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory DataGiveawayItem.fromJson(Map<String, dynamic> json) {
    return DataGiveawayItem(
      id: json['id'],
      dataName: json['data_name'],
      dataSize: json['data_size'],
      dataQuantity: json['data_quantity'],
      dataQuantityRemaining: json['data_quantity_remaining'],
      network: json['network'],
      planId: json['plan_id'],
      isAvailable: json['is_available'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      updatedAt: DateTime.parse(json['updated_at']).toLocal(),
    );
  }

  // Widget get networkIcon {
  //   switch (network.toLowerCase()) {
  //     case 'mtn':

  //       break;
  //     default:
  //   }
  // };
}
