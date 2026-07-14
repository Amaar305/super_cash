import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

extension CardTransactionStatusX on CardTransaction {
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'success':
        return AppColors.green;
      case 'failed':
      case 'failure':
        return AppColors.red;
      case 'pending':
        return AppColors.orange;
      default:
        return AppColors.grey;
    }
  }

  String get statusLabel {
    if (status.isEmpty) return status;
    return status[0].toUpperCase() + status.substring(1);
  }
}

class CardTransactionTile extends StatelessWidget {
  const CardTransactionTile({super.key, required this.transaction});
  final CardTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final statusColor = transaction.statusColor;

    return Tappable.faded(
      onTap: () => context.goNamedSafe(
        RNames.virtualCardTransactionDetail,
        extra: transaction,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.credit_card_outlined,
              color: statusColor,
              size: 20,
            ),
          ),
          Gap.h(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxs,
              children: [
                Text(
                  transaction.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsTextStyle(
                    fontWeight: AppFontWeight.medium,
                    fontSize: AppSpacing.sm + 1,
                  ),
                ),
                Text(
                  formatDateTime(transaction.createdAt),
                  style: poppinsTextStyle(
                    fontSize: AppSpacing.sm - 1,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Gap.h(AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: AppSpacing.xxs,
            children: [
              Text(
                transaction.formattedAmount,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: AppSpacing.sm + 1,
                ),
              ),
              Text(
                transaction.statusLabel,
                style: poppinsTextStyle(
                  fontSize: AppSpacing.sm - 1,
                  fontWeight: AppFontWeight.medium,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
