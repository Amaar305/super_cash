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
    return Column(
      spacing: AppSpacing.md,
      children: [
        ReferralTypeOption(
          title: 'Continue with App Services',
          description: 'Use our app services and enjoy seamless integration.',
          isSelected: isSelected == true,
          onTap: () =>
              context.read<ReferralTypeCubit>().onSelectReferralType(true),
        ),

        ReferralTypeOption(
          title: 'Use Referral Service',
          description: 'Refer a business and earn rewards.',
          isSelected: isSelected == false,
          onTap: () =>
              context.read<ReferralTypeCubit>().onSelectReferralType(false),
        ),
      ],
    );
  }
}
