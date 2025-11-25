import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/account/account.dart';

class ResetTransactionPinButton extends StatelessWidget {
  const ResetTransactionPinButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ResetTransactionPinCubit element) => element.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: 'Reset',
      onPressed: () {
        context.read<ResetTransactionPinCubit>().submit((m) {
          if (!context.mounted) return;
          context.showConfirmationBottomSheet(
            title: 'Transaction PIN Reset!',
            description: m,
            okText: AppStrings.done,
            onDone: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        });
      },
    );
  }
}
