import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

class DontHaveAccountButton extends StatelessWidget {
  const DontHaveAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final isLoading =
        context.select((LoginCubit element) => element.state.status.isLoading);

    return Tappable.scaled(
      onTap: isLoading ? null : () => cubit.changeAuth(showLogin: false),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: AppStrings.dontHaveAnAccount,
            children: [
              TextSpan(
                text: AppStrings.createAccount,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blue,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: AppFontWeight.light,
          ),
        ),
      ),
    );
  }
}
