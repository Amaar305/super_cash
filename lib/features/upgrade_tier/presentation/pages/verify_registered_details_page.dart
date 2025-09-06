import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class VerifyRegisteredDetailsPage extends StatelessWidget {
  const VerifyRegisteredDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xlg,
      children: [
        VerifyRegisteredDetailsForm(),
        SizedBox(),
        VerifyRegisteredDetailsButton(),
      ],
    );
  }
}

class VerifyRegisteredDetailsButton extends StatelessWidget {
  const VerifyRegisteredDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (UpgradeTierCubit element) => element.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.next,
      onPressed: () => context.read<UpgradeTierCubit>().checkDetails(),
    );
  }
}
