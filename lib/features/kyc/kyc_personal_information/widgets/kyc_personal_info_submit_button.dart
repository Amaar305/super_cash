import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/cubit/kyc_personal_information_cubit.dart';

class KycPersonalInfoSubmitButton extends StatelessWidget {
  const KycPersonalInfoSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.select(
      (KycPersonalInformationCubit c) => c.state.status.isSubmitting,
    );
    final alreadySubmitted = context.select(
      (KycPersonalInformationCubit c) => c.state.alreadySubmitted,
    );
    final locked = alreadySubmitted && !KycFlags.allowKycEdit;
    return PrimaryButton(
      isLoading: isSubmitting,
      label: locked ? 'Editing Disabled' : 'Save & Continue',
      onPressed: locked
          ? null
          : () => context.read<KycPersonalInformationCubit>().submitPersonalInfo(),
    );
  }
}
