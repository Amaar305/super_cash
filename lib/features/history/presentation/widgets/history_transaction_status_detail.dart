import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class HistoryTransactionStatusDetail extends StatelessWidget {
  const HistoryTransactionStatusDetail({super.key, required this.transaction});
  final TransactionResponse transaction;

  Color? get transactionColor {
    if (transaction.transactionStatus.isFailed) {
      return AppColors.red;
    }
    if (transaction.transactionStatus.isSuccess) {
      return AppColors.green;
    }
    if (transaction.transactionStatus.isPending) {
      return AppColors.orange;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 57),
          decoration: BoxDecoration(
            color: transactionColor?.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.sm,
            children: [
              Icon(
                Icons.verified,
                size: AppSize.iconSizeSmall,
                color: transactionColor,
              ),
              FittedBox(
                child: Text(
                  transaction.transactionStatus.isFailed
                      ? 'Transaction failed'
                      : transaction.transactionStatus.isPending
                      ? 'Transaction pending'
                      : transaction.transactionStatus.isRefund
                      ? 'Transaction Refund'
                      : 'Transaction successfully',
                  style: poppinsTextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Gap.v(AppSpacing.sm),
        Text(
          transaction.formattedAmount,
          style: poppinsTextStyle(
            fontSize: context.titleLarge?.fontSize,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Gap.v(AppSpacing.xs),
        Text(
          'Transaction amount',
          style: poppinsTextStyle(fontSize: 10, color: AppColors.hinTextColor),
        ),
      ],
    );
  }
}
