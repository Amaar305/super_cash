import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../history.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({
    super.key,
    required this.transactions,
    required this.hasReachedMax,
  });

  final List<TransactionResponse> transactions;
  final bool hasReachedMax;

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HistoryCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transactions.isEmpty) {
      return Center(child: Text('empty'));
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.hasReachedMax
          ? widget.transactions.length
          : widget.transactions.length + 1,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      // padding: EdgeInsets.only(bottom: 20),
      itemBuilder: (context, index) {
        if (index >= widget.transactions.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        final transaction = widget.transactions[index];
        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.md),
          child: TransactionTile(transaction: transaction),
        );
      },
    );
  }
}
