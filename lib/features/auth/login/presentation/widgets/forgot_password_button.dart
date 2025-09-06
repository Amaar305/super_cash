import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../forgot_password/presentation/pages/forgot_password_page.dart';
import '../presentation.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: RememberMeButton()),
          Expanded(child: ForgotPasswordButton()),
        ],
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (LoginCubit element) => element.state.status.isLoading,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Tappable.faded(
          throttle: true,
          throttleDuration: 650.ms,
          onTap: isLoading
              ? null
              : () => Navigator.pushAndRemoveUntil(
                  context,
                  ManageForgotPasswordPage.route(),
                  (_) => true,
                ),
          child: Text(
            AppStrings.forgotPassword,
            style: TextStyle(
              color: AppColors.red,
              fontWeight: AppFontWeight.bold,
              // decoration: TextDecoration.underline,
              decorationColor: AppColors.blue,
              fontFamily: 'MonaSans',
            ),
          ),
        ),
      ],
    );
  }
}

class RememberMeButton extends StatelessWidget {
  const RememberMeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final rememberMe = context.select((LoginCubit b) => b.state.rememberMe);
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Gap.h(AppSpacing.xs),
        SizedBox(
          width: 20,
          child: Checkbox(
            value: rememberMe,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: BorderSide(width: 0.5),
            onChanged: (val) =>
                context.read<LoginCubit>().onRememberMeChecked(val ?? true),
          ),
        ),
        Expanded(
          child: Tappable.faded(
            onTap: () {
              context.read<LoginCubit>().onRememberMeChecked(!rememberMe);
            },
            child: Text(
              AppStrings.rememberMe,
              style: TextStyle(
                // color: AppColors.red,
                fontWeight: AppFontWeight.bold,
                // decoration: TextDecoration.underline,
                decorationColor: AppColors.blue,
                fontFamily: 'MonaSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
