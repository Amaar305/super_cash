part of '../pages/giveway_detail_page.dart';

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final cashSteps = <_StepData>[
      _StepData(
        number: 1,
        title: 'View Available Cash Prizes',
        description:
            'Click the enter button below to view the available cash prizes reserved for distribution.',
      ),
      _StepData(
        number: 2,
        title: 'Claim Available Cash Prizes',
        description:
            'Claim one of the reserved cash prizes if available and eligible.',
      ),
      _StepData(
        number: 3,
        title: 'Provide Bank Account Details',
        description:
            'When claimed, provide your active bank account details to receive your claimed cash directly to your bank account.',
      ),
    ];
    final productSteps = <_StepData>[
      _StepData(
        number: 1,
        title: 'View Available Products',
        description:
            'Click the enter button below to view the available product prizes reserved for distribution.',
      ),
      _StepData(
        number: 2,
        title: 'Claim Available Product Prizes',
        description:
            'Claim one of the reserved product prizes if available and eligible.',
      ),
      _StepData(
        number: 3,
        title: 'Provide Shipping Details',
        description:
            'When claimed, provide your active house address to receive your claimed product.',
      ),
    ];
    final airtimeSteps = <_StepData>[
      _StepData(
        number: 1,
        title: 'View Available Airtime Prizes',
        description:
            'Click the enter button below to view the available airtimme prizes reserved for distribution.',
      ),
      _StepData(
        number: 2,
        title: 'Claim Available Airtime Prizes',
        description:
            'Claim one of the reserved airtime prizes if available and eligible.',
      ),
      _StepData(
        number: 3,
        title: 'Copy the PIN or Dial the USSD Code',
        description:
            'When claimed, copy the provided airtime PIN or dial the provided USSD code to redeem your claimed airtime.',
      ),
    ];
    final dataSteps = <_StepData>[
      _StepData(
        number: 1,
        title: 'View Available Data Prizes',
        description:
            'Click the enter button below to view the available data prizes reserved for distribution.',
      ),
      _StepData(
        number: 2,
        title: 'Claim Available Data Prizes',
        description:
            'Claim one of the reserved data prizes if available and eligible.',
      ),
      _StepData(
        number: 3,
        title: 'Provide Your Phone Number',
        description:
            'When claimed, provide your phone to receive your claimed data.',
      ),
    ];
    final directAirtimeSteps = <_StepData>[
      _StepData(
        number: 1,
        title: 'View Available Airtime Prizes',
        description:
            'Click the enter button below to view the available direct airtimme prizes reserved for distribution.',
      ),
      _StepData(
        number: 2,
        title: 'Claim Available Airtime Prizes',
        description:
            'Claim one of the reserved airtime prizes if available and eligible.',
      ),
      _StepData(
        number: 3,
        title: 'Provide Your Phone Number',
        description:
            'When claimed, provide your phone to receive your claimed airtime.',
      ),
    ];
    List<_StepData> steps;

    if (details.isCashGiveaway) {
      steps = cashSteps;
    } else if (details.isProductGiveaway) {
      steps = productSteps;
    } else if (details.isAirtimeGiveaway) {
      steps = airtimeSteps;
    } else if (details.isDirectAirtimeGiveaway) {
      steps = directAirtimeSteps;
    } else if (details.isDataGiveaway) {
      steps = dataSteps;
    } else {
      steps = [];
    }

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
