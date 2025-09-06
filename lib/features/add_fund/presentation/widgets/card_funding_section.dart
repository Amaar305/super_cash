import 'package:super_cash/core/common/widgets/reusable_coming_soon_widget.dart';
import 'package:flutter/material.dart';

class CardFundingSection extends StatelessWidget {
  const CardFundingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableComingSoonWidget(
      text:
          'Card funding services will be available soon. Stay tuned for updates.',
    );
    // return Column(
    //   spacing: AppSpacing.lg,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     PurchaseContainerInfo(
    //       child: Column(
    //         spacing: AppSpacing.sm,
    //         children: [
    //           'Ensure to send the exact amount inputted.',
    //           'Do not pay an amount above/below the inputted amount',
    //           'Do not save the account number generated on the next page as it expires in 40 minutes.',
    //           'Ensure to complete the payment within 40 minutes.'
    //         ]
    //             .map((e) => Row(
    //                   spacing: AppSpacing.sm,
    //                   children: [
    //                     Icon(
    //                       Icons.circle,
    //                       size: 5,
    //                     ),
    //                     Flexible(
    //                       child: Text(
    //                         e,
    //                         style: context.bodySmall
    //                             ?.copyWith(fontWeight: AppFontWeight.regular),
    //                       ),
    //                     )
    //                   ],
    //                 ))
    //             .toList(),
    //       ),
    //     ),
    //     SizedBox(),
    //     Text(
    //       'How much would you like to add',
    //       style: poppinsTextStyle(),
    //     ),
    //     AppTextField(
    //       hintText: '0.0',
    //       filled: Config.filled,
    //     ),
    //     Gap.v(AppSpacing.lg),
    //     PrimaryButton(
    //       label: AppStrings.proceedToPayment,
    //       onPressed: () {},
    //     )
    //   ],
    // );
  }
}
