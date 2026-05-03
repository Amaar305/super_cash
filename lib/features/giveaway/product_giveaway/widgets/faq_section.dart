part of '../pages/product_giveaway_details_page.dart';

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final items = <_FaqData>[
      _FaqData(
        question: 'How do I claim my prize?',
        answer: details.claimAnswer,
      ),
      _FaqData(
        question: 'Is there a limit per user?',
        answer: details.limitAnswer,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'COMMON QUESTIONS'),
        const SizedBox(height: 10),
        ...items.asMap().entries.map(
          (entry) => AnimatedPadding(
            duration: 200.ms,
            padding: EdgeInsets.only(
              bottom: entry.key == items.length - 1 ? 0 : 8,
            ),
            child: _FaqTile(
              item: entry.value,
              initiallyExpanded: entry.key == 0,
            ),
          ),
        ),
      ],
    );
  }
}
