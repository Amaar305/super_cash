import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/features/kyc/kyc_bvn/cubit/kyc_bvn_cubit.dart';

class KycBvnSubmitButton extends StatelessWidget {
  const KycBvnSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSubmitting =
        context.select((KycBvnCubit c) => c.state.status.isSubmitting);
    final alreadySubmitted =
        context.select((KycBvnCubit c) => c.state.alreadySubmitted);
    final locked = alreadySubmitted && !KycFlags.allowKycEdit;
    return PrimaryButton(
      isLoading: isSubmitting,
      label: locked ? 'Editing Disabled' : 'Submit BVN',
      onPressed: locked ? null : () => context.read<KycBvnCubit>().submitBvn(),
    );
  }
}
