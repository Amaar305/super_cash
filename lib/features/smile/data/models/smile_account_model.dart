import 'package:super_cash/features/smile/domain/domain.dart';

class SmileAccountModel extends SmileAccount {
  const SmileAccountModel({
    required super.accountId,
    required super.friendlyName,
  });

  factory SmileAccountModel.fromJson(Map<String, dynamic> json) {
    return SmileAccountModel(
      accountId: json['account_id'] as String? ?? '',
      friendlyName: json['friendly_name'] as String? ?? '',
    );
  }
}
