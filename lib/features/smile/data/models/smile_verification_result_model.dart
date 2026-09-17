import 'package:super_cash/features/smile/domain/domain.dart';

import 'smile_account_model.dart';

class SmileVerificationResultModel extends SmileVerificationResult {
  const SmileVerificationResultModel({
    super.customerName,
    required super.accounts,
  });

  factory SmileVerificationResultModel.fromJson(Map<String, dynamic> json) {
    final rawAccounts = json['accounts'] as List<dynamic>? ?? const [];
    return SmileVerificationResultModel(
      customerName: json['customer_name'] as String?,
      accounts: rawAccounts
          .map(
            (account) =>
                SmileAccountModel.fromJson(account as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
