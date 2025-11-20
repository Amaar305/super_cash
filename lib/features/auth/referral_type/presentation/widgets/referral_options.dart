import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralOptions extends StatelessWidget {
  const ReferralOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select(
      (ReferralTypeCubit element) => element.state.isIndividual,
    );
    final enabled = context.select(
      (ReferralTypeCubit element) =>
          element.state.referralTypeResult?.enabled ?? false,
    );
    return Column(
      spacing: AppSpacing.md,
      children: [
        ReferralTypeOption(
          title: 'Continue with App Services',
          description:
              'Use our app services without welcome Referral for Cash campaign.',
          isSelected: isSelected == false,
          onTap: () =>
              context.read<ReferralTypeCubit>().onSelectReferralType(false),
        ),

        ReferralTypeOption(
          title: 'Use Welcome Referral for Cash',
          description:
              'Refer new users and earn rewards for their transactions and activeness.',
          isSelected: isSelected == true,
          onTap: !enabled
              ? null
              : () => context.read<ReferralTypeCubit>().onSelectReferralType(
                  true,
                ),
        ),
      ],
    );
  }
}
