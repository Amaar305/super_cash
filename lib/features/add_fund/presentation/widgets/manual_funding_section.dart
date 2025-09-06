import 'package:super_cash/core/common/widgets/reusable_coming_soon_widget.dart';
import 'package:flutter/material.dart';

/// A section for manual funding, which is currently not implemented.
/// Displays a message indicating that manual funding services will be available soon.
class ManualFundingSection extends StatelessWidget {
  const ManualFundingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableComingSoonWidget(
      text:
          'Manual funding services will be available soon. Stay tuned for updates.',
    );
    // return Column(
    //   spacing: AppSpacing.lg,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       spacing: AppSpacing.lg,
    //       children: accounts.map(
    //         (bank) {
    //           return Expanded(
    //             child: BankDetailCard(
    //               bankDetail: bank,
    //               label: 'Account ${accounts.indexOf(bank) + 1}',
    //             ),
    //           );
    //         },
    //       ).toList(),
    //     ),
    //     PurchaseContainerInfo(
    //       child: Column(
    //         spacing: AppSpacing.sm,
    //         children: [
    //           "You are required to transfer your desired amount to any of the account numbers displayed above.",
    //           'After you’ve completed the transfer, click on the button below (I’ve sent the money) to complete the remaining processes.',
    //           'Manual funding is free of charge.',
    //           'You may experience a delay in crediting your wallet due to manual confirmation and crediting.'
    //         ]
    //             .map(
    //               (e) => Row(
    //                 spacing: AppSpacing.sm,
    //                 children: [
    //                   const Icon(
    //                     Icons.circle,
    //                     size: 5,
    //                   ),
    //                   Flexible(
    //                     child: Text(
    //                       e,
    //                       style: context.bodySmall
    //                           ?.copyWith(fontWeight: AppFontWeight.regular),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             )
    //             .toList(),
    //       ),
    //     ),
    //     const Gap.v(AppSpacing.lg),
    //     PrimaryButton(
    //       label: AppStrings.iveSentTheAmount,
    //       onPressed: () {},
    //     )
    //   ],
    // );
  }
}
