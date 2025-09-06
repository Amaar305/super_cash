
import '../../domain/entities/airtime.dart';

class AirtimeModel extends Airtime {
  AirtimeModel({
    required super.status,
    required super.statusMessage,
    required super.id,
    required super.amount,
    required super.service,
    required super.message,
    required super.previousBalance,
    required super.newBalance,
    required super.createDate,
  });

  factory AirtimeModel.fromJson(Map<String, dynamic> json) {
    return AirtimeModel(
      status: json['status'] ?? '',
      statusMessage: json['Status'] ?? '',
      id: json['id'] ?? '',
      amount: json['amount'] ?? '',
      service: json['service'] ?? '',
      message: json['msg'],
      previousBalance: (json['previous_balance'] as num?)?.toDouble() ?? 0.0,
      newBalance: (json['new_balance'] as num?)?.toDouble() ?? 0.0,
      createDate: json['create_date'] ?? '',
    );
  }
}
