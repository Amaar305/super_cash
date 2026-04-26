class ProductClaimAddressModel {
  final String id;
  final String productId;
  final String fullName;
  final String phoneNumber;
  final String address;
  final String deliveryStatus;
  final DateTime createdAt;

  const ProductClaimAddressModel({
    required this.id,
    required this.productId,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.deliveryStatus,
    required this.createdAt,
  });

  factory ProductClaimAddressModel.fromJson(Map<String, dynamic> json) {
    return ProductClaimAddressModel(
      id: json['id'],
      productId: json['product_id'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      deliveryStatus: json['delivery_status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['created_at']).toLocal(),
    );
  }
}
