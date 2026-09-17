import 'package:super_cash/features/smile/domain/domain.dart';

class SmileTransactionStatusModel extends SmileTransactionStatus {
  const SmileTransactionStatusModel({
    required super.status,
    required super.message,
  });

  factory SmileTransactionStatusModel.fromJson(Map<String, dynamic> json) {
    return SmileTransactionStatusModel(
      status: json['status'] as String? ?? 'failed',
      message: json['message'] as String? ?? '',
    );
  }
}
