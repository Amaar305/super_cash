import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AirtimeVTUButtons extends StatelessWidget {
  const AirtimeVTUButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (AirtimeCubit c) => c.state.status.isLoading,
    );
    return VTUActionButtons(
      isLoading: isLoading,
      onBeneficiaryTapped: (beneficiary) {
        if (beneficiary == null) return;
        context.read<AirtimeCubit>().onPhoneChanged(beneficiary.phone);
        context.read<AirtimeCubit>().onNetworkChanged(beneficiary.network);
      },
      onContactPicked: (newValue) =>
          context.read<AirtimeCubit>().onPhoneChanged(newValue),
      onNumberPasted: (newValue) {
        logI(newValue);
        context.read<AirtimeCubit>().onPhoneChanged(newValue);
      },
    );
  }
}
