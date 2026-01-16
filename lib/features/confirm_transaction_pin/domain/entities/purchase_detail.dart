

import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';

class PurchaseDetail {
  final String amount;
  final String title;
  final String description;
  final PurchaseType purchaseType;

  const PurchaseDetail({
    required this.amount,
    required this.title,
    required this.description,
    required this.purchaseType,
  });
}
