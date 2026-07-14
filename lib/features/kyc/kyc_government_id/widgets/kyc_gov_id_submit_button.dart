import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/features/kyc/kyc_government_id/cubit/kyc_government_id_cubit.dart';

class KycGovIdSubmitButton extends StatelessWidget {
  const KycGovIdSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isUploading = context.select(
      (KycGovernmentIdCubit c) => c.state.status.isUploading,
    );
    final alreadySubmitted = context.select(
      (KycGovernmentIdCubit c) => c.state.alreadySubmitted,
    );
    final locked = alreadySubmitted && !KycFlags.allowKycEdit;
    return PrimaryButton(
      isLoading: isUploading,
      label: locked ? 'Editing Disabled' : 'Upload Document',
      onPressed: locked
          ? null
          : () => context.read<KycGovernmentIdCubit>().uploadDocument(),
    );
  }
}
