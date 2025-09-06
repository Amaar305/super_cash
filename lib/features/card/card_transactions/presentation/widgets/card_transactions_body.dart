import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class CardTransactionsBody extends StatelessWidget {
  const CardTransactionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardTransactionsCubit, CardTransactionsState>(
      builder: (context, state) {
        if (_shouldShowLoading(state)) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.status == CardTransactionsStatus.failure &&
            state.data.isEmpty) {
          return _buildFailureState(context, state.message);
        }

        if (state.status == CardTransactionsStatus.suspended) {
          return const Center(child: Text('Transactions suspended'));
        }

        // Default case: show the transaction table
        return Expanded(child: CardTransactionTable(transactions: state.data));
      },
    );
  }

  bool _shouldShowLoading(CardTransactionsState state) {
    return state.status == CardTransactionsStatus.initial ||
        (state.status == CardTransactionsStatus.loading && state.data.isEmpty);
  }

  Widget _buildFailureState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => context
                .read<CardTransactionsCubit>()
                .fetchInitialTransactions(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
