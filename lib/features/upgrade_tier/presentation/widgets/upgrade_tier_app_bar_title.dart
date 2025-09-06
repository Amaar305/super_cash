import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeTierAppBarTitle extends StatelessWidget {
  const UpgradeTierAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = context.select(
      (UpgradeTierCubit cubit) => cubit.state.currentStep,
    );

    final title = switch (currentStep) {
      1 => AppStrings.verifyRegisteredDetails,
      2 => AppStrings.addressVerification,
      _ => AppStrings.submitKycDocument,
    };
    return AppAppBarTitle(title);
  }
}
