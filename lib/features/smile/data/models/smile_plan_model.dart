import 'package:super_cash/features/smile/domain/domain.dart';

class SmilePlanModel extends SmilePlan {
  const SmilePlanModel({
    required super.id,
    required super.variationCode,
    required super.name,
    required super.variationAmount,
    required super.charge,
    required super.total,
  });

  factory SmilePlanModel.fromJson(Map<String, dynamic> json) {
    return SmilePlanModel(
      id: json['id'] as String? ?? '',
      variationCode: json['variation_code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      variationAmount: _toDouble(json['variation_amount']),
      charge: _toDouble(json['charge']),
      total: _toDouble(json['total']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}
