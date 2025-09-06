import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SaveBeneficiaryButton extends StatelessWidget {
  const SaveBeneficiaryButton({super.key, this.beneficiary});
  final Beneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.status.isLoading,
    );

    return PrimaryButton(
      isLoading: isLoading,
      label: beneficiary == null ? AppStrings.save : AppStrings.update,
      onPressed: () {
        if (beneficiary == null) {
          context.read<SaveUpdateBeneficiaryCubit>().saveBeneficiary((_) {
            context.pop(true);
          });
        } else {
          context.read<SaveUpdateBeneficiaryCubit>().updateBeneficiary((_) {
            context.pop(true);
          });
        }
      },
    );
  }
}
