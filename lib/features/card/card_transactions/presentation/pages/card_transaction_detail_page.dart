import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/card/card.dart';

class CardTransactionDetailPage extends StatelessWidget {
  const CardTransactionDetailPage({super.key, required this.transaction});
  final CardTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final statusColor = transaction.statusColor;

    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('Transaction Details'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      Icons.credit_card_outlined,
                      color: statusColor,
                      size: 26,
                    ),
                  ),
                  Gap.v(AppSpacing.md),
                  Text(
                    transaction.formattedAmount,
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppSpacing.xlg,
                    ),
                  ),
                  Gap.v(AppSpacing.xs),
                  Text(
                    transaction.statusLabel,
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.medium,
                      fontSize: AppSpacing.sm + 1,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
            Gap.v(AppSpacing.xlg),
            CardBorderedContainer(
              height: null,
              child: Column(
                children: [
                  CardDetailTitleWithValue(
                    title: 'Description',
                    value: transaction.description,
                  ),
                  CardDetailTitleWithValue(
                    title: 'Card',
                    value: transaction.masked,
                  ),
                  CardDetailTitleWithValue(
                    title: 'Currency',
                    value: transaction.currency,
                  ),
                  CardDetailTitleWithValue(
                    title: 'Date',
                    value: formatDateTime(transaction.createdAt),
                    isCopyable: false,
                  ),
                  CardDetailTitleWithValue(
                    title: 'Reference ID',
                    value: transaction.refId,
                  ),
                  CardDetailTitleWithValue(
                    title: 'Transaction ID',
                    value: transaction.transId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
