part of '../pages/giveway_detail_page.dart';

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    List<_FaqData> generics = [
      _FaqData(
        question: 'Can I win one of the prizes?',
        answer:
            'Yes, you can claim one of the prizes as per as you met the eligibility criteria and you are fast enough to grab one.',
      ),
      _FaqData(
        question: 'What is the eligibility criteria?',
        answer:
            'Eligibility criteria are specific rules set by the Super Cash management to meet before being able to win the giveaway. e.g., User must be in tier two before winning. ',
      ),
    ];

    final cash = [
      _FaqData(
        question: 'How long does it take to receive a claimed reward?',
        answer: 'Rewards are delivered instantly unless otherwise specified.',
      ),
      _FaqData(
        question: 'Can I use a third-party account number?',
        answer: 'Yes, you can use a third-party account number.',
      ),
      _FaqData(
        question:
            'What should I do if I provide an account number but do not receive the reward?',
        answer:
            'This issue is unlikely to happen. However, if it does, please contact our customer support team for assistance.',
      ),
      _FaqData(
        question:
            'Whenever I receive an ongoing giveaway announcement, all available cash prizes have already been claimed.',
        answer:
            'This situation is uncommon. However, if it occurs, please contact our customer support team for assistance.',
      ),
    ];
    final product = [
      _FaqData(
        question: 'How long does it take to receive a claimed reward?',
        answer: 'Rewards are delivered within 3-5 business days.',
      ),
      _FaqData(
        question: 'Can I use a third-party address?',
        answer: 'Yes, you can use a third-party address.',
      ),
      _FaqData(
        question:
            'What should I do if I provide a shipping address but do not receive the reward?',
        answer:
            'This issue is unlikely to happen. However, if it does, please contact our customer support team for assistance.',
      ),
      _FaqData(
        question:
            'Whenever I receive an ongoing giveaway announcement, all available product prizes have already been claimed.',
        answer:
            'This situation is uncommon. However, if it occurs, please contact our customer support team for assistance.',
      ),
    ];

    final airtime = [
      _FaqData(
        question: 'How long does it take to receive a claimed reward?',
        answer: 'Rewards are delivered instantly.',
      ),
      _FaqData(
        question: 'Can I use a third-party phone number?',
        answer: 'Yes, you can use a third-party phone number.',
      ),
      _FaqData(
        question:
            'What should I do if I provide a phone number but do not receive the reward?',
        answer:
            'This issue is unlikely to happen. However, if it does, please contact our customer support team for assistance.',
      ),
      _FaqData(
        question:
            'Whenever I receive an ongoing giveaway announcement, all available airtime prizes have already been claimed.',
        answer:
            'Might be late to the giveaway. Please try to be faster next time. However, if you think this is an error, please contact our customer support team for assistance.',
      ),
    ];

    final airtimePIN = [
      _FaqData(
        question: 'How long does it take to receive a claimed reward?',
        answer: 'Rewards are delivered instantly.',
      ),

      _FaqData(
        question:
            'Whenever I receive an ongoing giveaway announcement, all available airtime prizes have already been claimed.',
        answer:
            'Might be late to the giveaway. Please try to be faster next time. However, if you think this is an error, please contact our customer support team for assistance.',
      ),
    ];

    final data = [
      _FaqData(
        question: 'How do data giveaways work?',
        answer:
            'Users can participate in data giveaways for a chance to receive free mobile data rewards.',
      ),
      _FaqData(
        question: 'How long does it take to receive a claimed data reward?',
        answer:
            'Data rewards are usually delivered instantly unless otherwise stated.',
      ),
      _FaqData(
        question: 'Can I send the data reward to another phone number?',
        answer:
            'Yes, you can provide a different phone number to receive the data reward.',
      ),
      _FaqData(
        question: 'What should I do if I do not receive my data reward?',
        answer:
            'If your data reward is not delivered after a successful claim, please contact our customer support team for assistance.',
      ),
      _FaqData(
        question:
            'Why are all data rewards already claimed when I try to participate?',
        answer:
            'Data giveaways are claimed on a first-come, first-served basis and may run out quickly once announced.',
      ),
    ];

    if (details.isDirectAirtimeGiveaway) {
      generics += airtime;
    } else if (details.isAirtimeGiveaway) {
      generics += airtimePIN;
    } else if (details.isCashGiveaway) {
      generics += cash;
    } else if (details.isProductGiveaway) {
      generics += product;
    } else if (details.isDataGiveaway) {
      generics += data;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'COMMON QUESTIONS'),
        const SizedBox(height: 10),
        ...generics.asMap().entries.map(
          (entry) => AnimatedPadding(
            duration: 200.ms,
            padding: EdgeInsets.only(
              bottom: entry.key == generics.length - 1 ? 0 : 8,
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
