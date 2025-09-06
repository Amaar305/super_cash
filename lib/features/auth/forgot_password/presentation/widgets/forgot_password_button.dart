import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth.dart';

class ForgotButtonSendEmailButton extends StatelessWidget {
  const ForgotButtonSendEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.send,
      onPressed: () {
        context.read<ForgotPasswordCubit>().onSubmit(
          onSuccess: () => context.read<ManagePasswordCubit>().changeScreen(
            showForgotPassword: false,
          ),
        );
      },
    );
  }
}
