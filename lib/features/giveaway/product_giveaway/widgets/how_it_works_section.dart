part of '../pages/product_giveaway_details_page.dart';

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final steps = <_StepData>[
      _StepData(
        number: 1,
        title: 'Join Giveaway',
        description:
            'Click the enter button below to register your interest in this session.',
      ),
      _StepData(
        number: 2,
        title: 'Wait for Selection',
        description:
            'Our system randomly selects winners from registered users during the event.',
      ),
      _StepData(
        number: 3,
        title: details.finalStepTitle,
        description: details.finalStepDescription,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'HOW IT WORKS'),
        const SizedBox(height: 10),
        ...steps.map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _StepCard(step: step),
          ),
        ),
      ],
    );
  }
}
