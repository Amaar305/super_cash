import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class PurchaseConfirmationAmount extends StatelessWidget {
  const PurchaseConfirmationAmount({super.key, required this.amount});
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Total Amount',
          style: poppinsTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGrey,
          ),
        ),
        Text.rich(
          TextSpan(
            text: 'N',
            style: poppinsTextStyle(
              fontWeight: AppFontWeight.black,
              color: AppColors.blue,
            ),
            children: [
              TextSpan(
                text: amount,
                style: poppinsTextStyle(
                  fontSize: 32,
                  fontWeight: AppFontWeight.black,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          style: poppinsTextStyle(
            fontSize: 32,
            fontWeight: AppFontWeight.black,
          ),
        ),
      ],
    );
  }
}
