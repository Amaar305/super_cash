import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/features/kyc/kyc_selfie/cubit/kyc_selfie_cubit.dart';

class KycSelfieSubmitButton extends StatelessWidget {
  const KycSelfieSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isUploading = context.select(
      (KycSelfieCubit c) => c.state.status.isUploading,
    );
    final alreadySubmitted = context.select(
      (KycSelfieCubit c) => c.state.alreadySubmitted,
    );
    final locked = alreadySubmitted && !KycFlags.allowKycEdit;
    return PrimaryButton(
      isLoading: isUploading,
      label: locked ? 'Editing Disabled' : 'Upload Selfie',
      onPressed: locked
          ? null
          : () => context.read<KycSelfieCubit>().submitSelfie(),
    );
  }
}
