import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

class SmilePurchaseActionButtons extends StatelessWidget {
  const SmilePurchaseActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SmilePurchaseCubit c) => c.state.status.isLoading,
    );
    return VTUActionButtons(
      isLoading: isLoading,
      onContactPicked: (newValue) =>
          context.read<SmilePurchaseCubit>().onPhoneChanged(newValue),
      onNumberPasted: (newValue) =>
          context.read<SmilePurchaseCubit>().onPhoneChanged(newValue),
      onBeneficiaryTapped: (beneficiary) {
        if (beneficiary == null) return;
        context.read<SmilePurchaseCubit>().onPhoneChanged(beneficiary.phone);
      },
    );
  }
}
