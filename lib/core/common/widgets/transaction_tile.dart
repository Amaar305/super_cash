import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
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

  SvgGenImage get transactionIcon {
    switch (transaction?.transactionType) {
      case TransactionType.airtime:
        return Assets.icons.airttime;
      case TransactionType.data:
        return Assets.icons.data;
      case TransactionType.cable:
        return Assets.icons.cable;
      case TransactionType.electricity:
        return Assets.icons.electricity;
      case TransactionType.card:
      case TransactionType.cardholder:
        return Assets.icons.creditCards;
      case TransactionType.cardfunding:
      case TransactionType.walletfunding:
        return Assets.icons.fund;
      case TransactionType.credit:
        return Assets.icons.iconWallet;
      case TransactionType.debit:
        return Assets.icons.swap;
      default:
        return Assets.icons.transferLine;
    }
  }

  List<Color> get transactionGradient {
    switch (transaction?.transactionType) {
      case TransactionType.airtime:
      case TransactionType.data:
        return [AppColors.orange, AppColors.lightBlue];
      case TransactionType.cable:
      case TransactionType.electricity:
        return [AppColors.deepBlue, AppColors.lightBlue];
      case TransactionType.cardfunding:
      case TransactionType.walletfunding:
      case TransactionType.credit:
        return [AppColors.green.shade400, AppColors.green];
      case TransactionType.debit:
        return [AppColors.red.shade300, AppColors.red];
      default:
        return [AppColors.blue, AppColors.deepBlue];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () =>
          context.goNamedSafe(RNames.transactionDetail, extra: transaction),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: transactionGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              boxShadow: [
                BoxShadow(
                  color: transactionGradient.last.withValues(alpha:0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha:0.14),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white.withValues(alpha:0.18),
                  ),
                ),
                child: transactionIcon.svg(
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
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
