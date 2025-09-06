import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/card/card_transactions/presentation/cubit/card_transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class CardTransactionTable extends StatelessWidget {
  const CardTransactionTable({super.key, required this.transactions});

  final List<CardTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: _createColumns(context),
        rows: _createRows(),
        border: TableBorder(),
        headingRowColor: WidgetStatePropertyAll(AppColors.lightBlueFilled),
        horizontalMargin: 0,
        dividerThickness: 0.2,
        // columnSpacing: 100,
      ),
    );
  }

  List<DataColumn> _createColumns(BuildContext context) {
    const style = TextStyle(fontWeight: AppFontWeight.semiBold, fontSize: 11);
    return [
      const DataColumn(
        label: Flexible(child: Text('Transaction Details', style: style)),
      ),
      const DataColumn(label: Text('Currency', style: style)),
      DataColumn(
        label: const Text('Amount', style: style),
        onSort: (columnIndex, _) {
          context.read<CardTransactionsCubit>().sortByAmount();
        },
      ),
    ];
  }

  List<DataRow> _createRows() {
    const style = TextStyle(fontWeight: AppFontWeight.regular, fontSize: 11);
    return transactions.map((e) {
      return DataRow(
        cells: [
          DataCell(Text(e.description, style: style)),
          DataCell(Text(e.currency, style: style)),
          DataCell(Text(e.formattedAmount, style: style)),
        ],
      );
    }).toList();
  }
}
