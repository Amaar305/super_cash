part of '../pages/product_giveaway_details_page.dart';

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            title: 'Total Value',
            value: details.valueToWin,
            subtitle: details.valueSupportText,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetricCard(
            title: 'Total Winners',
            value: details.totalWinners,
            subtitle: details.winnerSupportText,
          ),
        ),
      ],
    );
  }
}
