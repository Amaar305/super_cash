import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressVerificationPage extends StatelessWidget {
  const AddressVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xlg,
      children: [AddressVerificationForm(), AddressVerificationNextButton()],
    );
  }
}

class AddressVerificationNextButton extends StatelessWidget {
  const AddressVerificationNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (UpgradeTierCubit element) => element.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.next,
      onPressed: () => context.read<UpgradeTierCubit>().checkAddress(),
    );
  }
}
