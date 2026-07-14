import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';

import '../presentation.dart';

class CardTransactionsBody extends StatelessWidget {
  const CardTransactionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardTransactionsCubit, CardTransactionsState>(
      builder: (context, state) {
        if (_shouldShowLoading(state)) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        if (state.status == CardTransactionsStatus.failure &&
            state.data.isEmpty) {
          return Expanded(child: _FailureState(message: state.message));
        }

        if (state.status == CardTransactionsStatus.suspended) {
          return const Expanded(
            child: AppEmptyState(
              title: 'Transactions suspended',
              description: 'This card\'s transaction history is unavailable '
                  'right now.',
              icon: Icons.block_outlined,
            ),
          );
        }

        if (state.data.isEmpty) {
          return const Expanded(
            child: AppEmptyState(
              title: 'No transactions yet',
              description:
                  'Transactions made with this card will show up here.',
              icon: Icons.receipt_long_outlined,
            ),
          );
        }

        return Expanded(
          child: RefreshIndicator.adaptive(
            onRefresh: () =>
                context.read<CardTransactionsCubit>().fetchInitialTransactions(),
            child: CardTransactionListView(
              transactions: state.data,
              hasReachedMax: state.hasReachedMax,
              onLoadMore: () =>
                  context.read<CardTransactionsCubit>().fetchNextPage(),
            ),
          ),
        );
      },
    );
  }

  bool _shouldShowLoading(CardTransactionsState state) {
    return state.status == CardTransactionsStatus.initial ||
        (state.status == CardTransactionsStatus.loading && state.data.isEmpty);
  }
}

class _FailureState extends StatelessWidget {
  const _FailureState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: 'Couldn\'t load transactions',
      description: message.isNotEmpty
          ? message
          : 'Something went wrong. Please try again.',
      icon: Icons.error_outline,
      action: SizedBox(
        width: 140,
        child: AppOutlinedButton(
          isLoading: false,
          label: 'Retry',
          onPressed: () =>
              context.read<CardTransactionsCubit>().fetchInitialTransactions(),
        ),
      ),
    );
  }
}
