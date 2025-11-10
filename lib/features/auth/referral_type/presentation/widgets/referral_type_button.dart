import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralTypeButton extends StatelessWidget {
  const ReferralTypeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select(
      (ReferralTypeCubit element) => element.state.isIndividual,
    );
    return PrimaryButton(
      label: AppStrings.proceed,
      onPressed: isSelected == null
          ? null
          : () {
              // Handle proceed action based on selected referral type
              if (isSelected) {
                // Proceed with individual referral flow
              } else {
                // Proceed with business referral flow
              }
            },
    );
  }
}
