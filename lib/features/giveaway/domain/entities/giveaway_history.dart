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

  String get _giveawayTypeCode => giveawayType.code.toLowerCase();

  bool get isAirtimeGiveaway => _giveawayTypeCode.contains('airtime');

  bool get isDataGiveaway => _giveawayTypeCode.contains('data');

  bool get isCashGiveaway => _giveawayTypeCode.contains('cash');

  bool get isProductGiveaway => _giveawayTypeCode.contains('product');

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

  ProductGiveawayModel get productGiveaway {
    final id = meta?['product_id'] as String? ?? '';
    final productName = meta?['product_name'] as String? ?? '';
    final description = meta?['product_description'] as String? ?? '';
    final productSpecification =
        (meta?['product_specification'] as List? ?? const [])
            .map((e) => e.toString())
            .toList();
    final productQuantity = (meta?['product_quantity'] as num?)?.toInt() ?? 0;
    final productQuantityRemaining =
        (meta?['product_quantity_remaining'] as num?)?.toInt() ?? 0;
    final isAvailable = meta?['is_available'] as bool? ?? false;
    final image = meta?['image'] as String? ?? '';
    final updatedAt =
        DateTime.tryParse(meta?['updated_at'] as String? ?? '')?.toLocal() ??
        createdAt;

    return ProductGiveawayModel(
      id: id,
      productName: productName,
      productDescription: description,
      productSpecification: productSpecification,
      productQuantity: productQuantity,
      productQuantityRemaining: productQuantityRemaining,
      isAvailable: isAvailable,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  DataGiveawayItem get dataGiveaway {
    final id = meta?['data_id'] as String? ?? '';
    final dataName = meta?['data_name'] as String? ?? '';
    final dataSize = meta?['data_size'] as String? ?? '';
    final dataQuantity = (meta?['data_quantity'] as num?)?.toInt() ?? 0;
    final dataQuantityRemaining =
        (meta?['data_quantity_remaining'] as num?)?.toInt() ?? 0;
    final network = meta?['network'] as String? ?? '';
    final planId = meta?['plan_id'] as String? ?? '';
    final isAvailable = meta?['is_available'] as bool? ?? false;
    final updatedAt =
        DateTime.tryParse(meta?['updated_at'] as String? ?? '')?.toLocal() ??
        createdAt;

    return DataGiveawayItem(
      id: id,
      dataName: dataName,
      dataSize: dataSize,
      dataQuantity: dataQuantity,
      dataQuantityRemaining: dataQuantityRemaining,
      network: network,
      planId: planId,
      isAvailable: isAvailable,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  CashGiveawayItem get cashGiveaway {
    final id = meta?['cash_id'] as String? ?? '';
    final cashName = meta?['cash_name'] as String? ?? '';
    final cashAmount = meta?['cash_amount'] as String? ?? amount;
    final description =
        meta?['cash_description'] as String? ?? this.description;
    final cashQuantity = (meta?['cash_quantity'] as num?)?.toInt() ?? 0;
    final cashQuantityRemaining =
        (meta?['cash_quantity_remaining'] as num?)?.toInt() ?? 0;
    final requiresBankDetails =
        meta?['requires_account_details'] as bool? ?? false;
    final isAvailable = meta?['is_available'] as bool? ?? false;
    final updatedAt =
        DateTime.tryParse(meta?['updated_at'] as String? ?? '')?.toLocal() ??
        createdAt;

    return CashGiveawayItem(
      id: id,
      cashName: cashName,
      cashAmount: cashAmount,
      description: description,
      cashQuantity: cashQuantity,
      cashQuantityRemaining: cashQuantityRemaining,
      requiresBankDetails: requiresBankDetails,
      isAvailable: isAvailable,
      createdAt: createdAt,
      updatedAt: updatedAt,
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
