import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, this.transaction});
  final TransactionResponse? transaction;
  Color? get transactionColor {
    if (transaction?.transactionStatus.isFailed ?? false) {
      return AppColors.red;
    }
    if (transaction?.transactionStatus.isSuccess ?? false) {
      return AppColors.green;
    }
    if (transaction?.transactionStatus.isPending ?? false) {
      return AppColors.orange;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () =>
          context.push(AppRoutes.transacttionDetail, extra: transaction),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.brightGrey,
              borderRadius: BorderRadius.circular(AppSpacing.md),
            ),
          ),
          Gap.h(AppSpacing.spaceUnit),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      transaction?.transactionType.name.toUpperCase() ??
                          'Buy Airtime (MTN)',
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.medium,
                        fontSize: AppSpacing.md,
                      ),
                    ),
                    Text(
                      transaction != null
                          ? formatDateTime(transaction!.createdAt)
                          : 'Today',
                      style: poppinsTextStyle(fontSize: AppSpacing.sm),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'N${transaction?.amount}',
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: AppSpacing.sm + 2,
                      ),
                    ),
                    Text(
                      transaction?.transactionStatus.name.capitalize ??
                          'Pending',
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.semiBold,
                        color: transactionColor,
                        fontSize: AppSpacing.sm + 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
