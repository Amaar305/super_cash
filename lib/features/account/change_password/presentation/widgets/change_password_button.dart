import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/change_password_cubit.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ChangePasswordCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.change,
      onPressed: () {
        context.read<ChangePasswordCubit>().submit((success) {
          context.showConfirmationBottomSheet(
            title: 'Password Changed!',
            okText: AppStrings.done,
            description: success,
            onDone: () {
              context.pop();
              context.pop();
            },
          );
        });
      },
    );
  }
}
