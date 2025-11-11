import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../verify.dart';

class VerifyOtpButton extends StatelessWidget {
  const VerifyOtpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (VerifyCubit bloc) => bloc.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.signUp,
      onPressed: () {
        context.read<VerifyCubit>().onSubmit((user) {
          showModalBottomSheet(
            context: context,
            builder: (context) => VerifyAccountBottomSheet(user: user),
          );
        });
      },
    );
  }
}
