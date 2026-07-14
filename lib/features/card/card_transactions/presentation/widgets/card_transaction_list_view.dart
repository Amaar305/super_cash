import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'card_transaction_tile.dart';

class CardTransactionListView extends StatefulWidget {
  const CardTransactionListView({
    super.key,
    required this.transactions,
    required this.hasReachedMax,
    this.onLoadMore,
  });

  final List<CardTransaction> transactions;
  final bool hasReachedMax;
  final VoidCallback? onLoadMore;

  @override
  State<CardTransactionListView> createState() =>
      _CardTransactionListViewState();
}

class _CardTransactionListViewState extends State<CardTransactionListView> {
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
    if (_isBottom) widget.onLoadMore?.call();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.hasReachedMax
          ? widget.transactions.length
          : widget.transactions.length + 1,
      separatorBuilder: (_, _) => Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Divider(height: 1, color: AppColors.brightGrey),
      ),
      itemBuilder: (context, index) {
        if (index >= widget.transactions.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return CardTransactionTile(
          transaction: widget.transactions[index],
        );
      },
    );
  }
}
