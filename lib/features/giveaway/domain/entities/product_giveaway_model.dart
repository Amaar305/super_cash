class ProductGiveawayModel {
  final String id;
  final String productName;
  final String productDescription;
  final List<String> productSpecification;
  final int productQuantity;
  final int productQuantityRemaining;
  final bool isAvailable;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get outOfStock => productQuantityRemaining < 1;

  const ProductGiveawayModel({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.productSpecification,
    required this.productQuantity,
    required this.productQuantityRemaining,
    required this.isAvailable,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductGiveawayModel.fromJson(Map<String, dynamic> json) {
    return ProductGiveawayModel(
      id: json['id'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      productSpecification: (json['product_specification'] as List)
          .map((e) => e as String)
          .toList(),
      productQuantity: (json['product_quantity'] as num).toInt(),
      productQuantityRemaining: (json['product_quantity_remaining'] as num)
          .toInt(),
      isAvailable: json['is_available'] as bool,
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      updatedAt: DateTime.parse(json['updated_at']).toLocal(),
    );
  }

  ProductGiveawayModel copyWith({
    String? id,
    String? productName,
    String? productDescription,
    List<String>? productSpecification,
    int? productQuantity,
    int? productQuantityRemaining,
    bool? isAvailable,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductGiveawayModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productSpecification: productSpecification ?? this.productSpecification,
      productQuantity: productQuantity ?? this.productQuantity,
      productQuantityRemaining:
          productQuantityRemaining ?? this.productQuantityRemaining,
      isAvailable: isAvailable ?? this.isAvailable,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// [
//   {
//     "id": "e70eb8a5-4519-43fd-b98e-52cec9d811da",
//     "product_name": "Samsung galaxy s26 ultra",
//     "product_description": "Stand a chance to win a Samsung galaxy s26 ultra blazing new blue teal colour.",
//     "product_specification": [
//       "128gb",
//       "8megapixel",
//       "blue in colour",
//       "2026 model"
//     ],
//     "product_quantity": 5,
//     "product_quantity_remaining": 4,
//     "is_available": true,
//     "created_at": "2026-04-16T14:42:18.065885+01:00",
//     "updated_at": "2026-04-16T17:30:06.594682+01:00",
//     "image": "http://127.0.0.1:8000/media/giveaway/product/iPhone-17-Pro-Max.jpg"
//   }
// ]
