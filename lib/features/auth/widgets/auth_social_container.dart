import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/auth.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary2.withValues(alpha: 0.08),
            offset: Offset(0, 2),
            blurRadius: 9,
            spreadRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }
}

class AuthSocialContainer extends StatelessWidget {
  const AuthSocialContainer({super.key, this.isLogin = true});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final authLabel = isLogin
        ? AppStrings.dontHaveAnAccount
        : AppStrings.alreadyHaveAnAccount;
    final authButtonLabel = !isLogin
        ? AppStrings.login
        : AppStrings.createAccount;
    return AuthContainer(
      child: Column(
        spacing: 16,
        children: [
          Text(
            'Connect with us on ',
            textAlign: TextAlign.center,
            style: MonaSansTextStyle.label(fontWeight: AppFontWeight.black),
          ),
          InquiryWidget(),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.lightDark,
                  width: double.infinity,
                  height: 2,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  authLabel,
                  textAlign: TextAlign.center,
                  style: MonaSansTextStyle.label(
                    fontWeight: AppFontWeight.black,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.lightDark,
                  width: double.infinity,
                  height: 2,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              isLoading: false,
              label: authButtonLabel,
              onPressed: () {
                context.read<AuthCubit>().changeAuth(showLogin: !isLogin);
              },
            ),
          ),
        ],
      ),
    );
  }
}
