import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/history/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/common.dart';

class HomeRecentTransactionSection extends StatelessWidget {
  const HomeRecentTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = context.select(
      (HistoryCubit value) => value.state.transactions.take(5).toList(),
    );
    final isLoading = context.select(
      (HistoryCubit element) => element.state.status.isLoading,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: TextStyle(fontWeight: AppFontWeight.semiBold),
              ),
              Tappable(
                onTap: () {},
                child: Icon(Icons.more_horiz_outlined, color: AppColors.grey),
              ),
            ],
          ),
          Gap.v(AppSpacing.spaceUnit),
          isLoading
              ? Loader()
              : Column(
                  spacing: AppSpacing.lg,
                  children: List.generate(
                    transactions.length,
                    (index) =>
                        TransactionTile(transaction: transactions[index]),
                  ),
                ),
        ],
      ),
    );
  }
}
