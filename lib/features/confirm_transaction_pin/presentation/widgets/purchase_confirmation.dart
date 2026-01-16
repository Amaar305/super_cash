import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';


class PurchaseConfirmation extends StatelessWidget {
  const PurchaseConfirmation({
    super.key,
    required this.amount,
    required this.title,
    required this.description,
    this.purchaseType = PurchaseType.others,
  });

  final String amount;
  final String title;
  final String description;
  final PurchaseType purchaseType;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        // Amount
        PurchaseConfirmationAmount(amount: amount),

        PurchaseConfirmationDetails(
          title: title,
          description: description,
          purchaseType: purchaseType,
        ),
      ],
    );
  }
}
