import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralTypeButton extends StatelessWidget {
  const ReferralTypeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select(
      (ReferralTypeCubit element) => element.state.isIndividual,
    );
    final isLoading = context.select(
      (ReferralTypeCubit element) => element.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.proceed,
      onPressed: isSelected == null
          ? null
          : () {
              // Handle proceed action based on selected referral type
              if (isSelected) {
                // Proceed with individual referral flow
                Navigator.push(
                  context,
                  ReferralSelectionPage.route(
                    context.read<ReferralTypeCubit>(),
                  ),
                );
              } else {
                // Process with automatic enrollment

                context.read<ReferralTypeCubit>().automaticEnrollment(
                  onEnrolled: (_) {
                    context.read<AppCubit>().userStarted(true);
                  },
                );
              }
            },
    );
  }
}
