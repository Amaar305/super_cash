import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/history/presentation/widgets/history_detail_tile.dart';

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
            trailingLabel: formatDateTime(
              transaction.createdAt,
            ).split(',').take(2).join(),
          ),
          HistoryDetailTile(
            label: 'Time',
            trailingLabel: formatDateTime(
              transaction.createdAt,
            ).split(',').last,
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
