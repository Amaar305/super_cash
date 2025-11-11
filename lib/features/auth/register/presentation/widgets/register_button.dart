import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (RegisterCubit bloc) => bloc.state.status.isLoading,
    );
    final agreedToTermsAndCondition = context.select(
      (RegisterCubit bloc) => bloc.state.agreedToTermsAndCondition,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.signUp,
      onPressed: !agreedToTermsAndCondition
          ? null
          : () {
              context.read<RegisterCubit>().submit((user) {
                context.read<AppCubit>().referralType();
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   ReferralTypePage.route(),
                //   (_) => true,
                // );
              });
            },
    );
  }
}
