import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';

class KycHomeAddressSubmitButton extends StatelessWidget {
  const KycHomeAddressSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.select(
      (KycHomeAddressCubit c) => c.state.status.isSubmitting,
    );
    final alreadySubmitted = context.select(
      (KycHomeAddressCubit c) => c.state.alreadySubmitted,
    );
    final locked = alreadySubmitted && !KycFlags.allowKycEdit;
    return PrimaryButton(
      isLoading: isSubmitting,
      label: locked ? 'Editing Disabled' : 'Save & Continue',
      onPressed: locked
          ? null
          : () => context.read<KycHomeAddressCubit>().submitAddress(),
    );
  }
}
