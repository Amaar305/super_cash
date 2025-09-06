import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/history/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HistoryView();
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(title: AppAppBarTitle(AppStrings.history)),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<HistoryCubit>().refreshTransactions();
        },
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: BlocListener<HistoryCubit, HistoryState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isError) {
                openSnackbar(
                  SnackbarMessage.error(title: state.message),
                  clearIfQueue: true,
                );
                return;
              }
            },
            child: Column(
              spacing: AppSpacing.lg,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HistorySearchField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HistoryFilterButton(),
                    TextButton.icon(
                      onPressed: context
                          .read<HistoryCubit>()
                          .refreshTransactions,
                      label: Text('Clear Filters'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.blue,
                      ),
                      icon: Icon(Icons.clear_all, size: 16),
                    ),
                  ],
                ),
                Gap.v(AppSpacing.xs),
                // TransactionDateLabel('Today'),
                _HistoryBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (_shouldShowLoading(state)) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.status == HistoryStatus.failure && state.data.isEmpty) {
          return _buildFailureState(context, state.message);
        }

        // Default case: show the transaction table
        return Expanded(
          child: HistoryListView(
            transactions: state.data,
            hasReachedMax: state.hasReachedMax,
          ),
        );
      },
    );
  }

  bool _shouldShowLoading(HistoryState state) {
    return state.status == HistoryStatus.initial ||
        (state.status == HistoryStatus.loading && state.data.isEmpty);
  }

  Widget _buildFailureState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => context.read<HistoryCubit>().refreshTransactions(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
