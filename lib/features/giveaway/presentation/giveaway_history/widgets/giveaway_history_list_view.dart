import 'package:flutter/material.dart';
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
    void onTapped(AirtimeGiveawayPin giveawayPin) {
      showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AirtimeGiveawaySuccessDialog(airtimeGiveawayPin: giveawayPin);
        },
      );
    }

    return SliverList.builder(
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: GiveawayCard(
          giveawayHistory: histories[index],
          key: ValueKey(index),
        ),
      ),
      itemCount: histories.length,
    );
  }
}
