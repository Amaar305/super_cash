import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app_strings/app_string.dart';
import '../../../../auth.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((ChangePasswordCubit cubit) => cubit.state.status.isLoading);
    final email =
        context.select((ForgotPasswordCubit b) => b.state.email.value);
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.submit,
      onPressed: () => context.read<ChangePasswordCubit>().submit(
            email: email,
          ),
    );
  }
}
