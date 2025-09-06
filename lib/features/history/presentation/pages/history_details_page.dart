import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class HistoryDetailsPage extends StatelessWidget {
  const HistoryDetailsPage({
    super.key,
    required this.transaction,
  });

  final TransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('Transaction Details'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            HistoryDetailHeader(transaction: transaction),
            Gap.v(AppSpacing.xlg),
            HistoryTransactionStatusDetail(transaction: transaction),
            Gap.v(AppSpacing.xlg),
            TransactionDetails(transaction: transaction),
            HistoryActionButtons(),
            Gap.v(AppSpacing.lg),
            HistoryReportButton()
          ],
        ),
      ),
    );
  }
}

class HistoryReportButton extends StatelessWidget {
  const HistoryReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: 'Report',
      onPressed: () {},
    );
  }
}

class HistoryActionButtons extends StatelessWidget {
  const HistoryActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: OutlineHistoryActionButton(
            title: 'Download',
            onPressed: () {},
          ),
        ),
        Expanded(
          child: OutlineHistoryActionButton(
            title: 'Share',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class OutlineHistoryActionButton extends StatelessWidget {
  const OutlineHistoryActionButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppButton.outlined(
      text: title,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: Size.fromHeight(50),
      ),
    );
  }
}

class HistoryTransactionStatusDetail extends StatelessWidget {
  const HistoryTransactionStatusDetail({
    super.key,
    required this.transaction,
  });
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
                style: context.bodySmall,
              ))
            ],
          ),
        ),
        Gap.v(AppSpacing.sm),
        Text(
          transaction.formattedAmount,
          style: context.titleLarge,
        ),
        Gap.v(AppSpacing.xs),
        Text(
          'Transaction amount',
          style: context.bodySmall?.copyWith(color: AppColors.hinTextColor),
        ),
      ],
    );
  }
}

class HistoryDetailHeader extends StatelessWidget {
  const HistoryDetailHeader({
    super.key,
    required this.transaction,
  });

  final TransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cool Pay',
              style: context.titleMedium,
            ),
            Text(
              'A Product of Cool Data',
              style: TextStyle(
                fontSize: 10,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Receipt',
              style: context.bodySmall
                  ?.copyWith(fontWeight: AppFontWeight.semiBold),
            ),
            Row(
              children: [
                Text(
                  formatDateTime(transaction.createdAt)
                      .split(',')
                      .take(2)
                      .join(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: AppFontWeight.regular,
                  ),
                ),
                Text(
                  formatDateTime(transaction.createdAt).split(',').last,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key, required this.transaction});
  final TransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xlg),
      alignment: Alignment(0, 0),
      child: Column(
        children: [
          HistoryDetailTile(
            label: 'Transaction ID',
            trailingLabel: transaction.reference,
          ),
          HistoryDetailTile(
            label: 'Type',
            trailingLabel: transaction.transactionType.name.capitalize,
          ),
          HistoryDetailTile(
            label: 'Amount',
            trailingLabel: transaction.formattedAmount,
          ),
          HistoryDetailTile(
            label: 'Date',
            trailingLabel:
                formatDateTime(transaction.createdAt).split(',').take(2).join(),
          ),
          HistoryDetailTile(
            label: 'Time',
            trailingLabel:
                formatDateTime(transaction.createdAt).split(',').last,
          ),
          HistoryDetailTile(
            label: 'Description',
            trailingLabel: transaction.description,
          ),
          HistoryDetailTile(
            label: 'Status',
            trailingLabel: transaction.transactionStatus.name.capitalize,
          ),
        ],
      ),
    );
  }
}

class HistoryDetailTile extends StatelessWidget {
  const HistoryDetailTile({
    super.key,
    required this.label,
    required this.trailingLabel,
  });

  final String label;
  final String trailingLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: 12,
                    ),
              ),
              Flexible(
                child: Text(
                  trailingLabel,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          Divider(
            // thickness: 0.7,
            color: Color.fromRGBO(237, 238, 242, 0.9),
          )
        ],
      ),
    );
  }
}
