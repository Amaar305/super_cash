part of '../pages/product_giveaway_details_page.dart';

class _CountdownSection extends StatelessWidget {
  const _CountdownSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    if (details.countdownTarget == null) {
      return const SizedBox.shrink();
    }

    return _CountdownCard(
      title: details.countdownCardTitle,
      target: details.countdownTarget!,
      hasEnded: details.isClosed,
    );
  }
}
