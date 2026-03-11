import 'package:flutter/material.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayHistoryListView extends StatelessWidget {
  const GiveawayHistoryListView({
    super.key,
    required this.histories,
    this.onLoadMore,
  });
  final List<GiveawayHistory> histories;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (histories.isEmpty) {
      return AppEmptyState(
        title: 'No available history',
        action: TextButton(onPressed: onLoadMore, child: Text('Refresh')),
      );
    }
    void onTapped(AirtimeGiveawayPin giveawayPin) {
      showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AirtimeGiveawaySuccessDialog(airtimeGiveawayPin: giveawayPin);
        },
      );
    }

    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) {
        // if (index == histories.length - 1) {}
        return GiveawayHistoryTile(
          giveawayHistory: histories[index],
          onTap: onTapped,
        );
      },
    );
  }
}
