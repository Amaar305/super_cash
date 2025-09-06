import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app_strings/app_string.dart';
import '../../../../auth.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});


  void _confirmGoBack(BuildContext context) => context.confirmAction(
        fn: () => context
            .read<ManagePasswordCubit>()
            .changeScreen(showForgotPassword: true),
        title: AppStrings.goBackTitle,
        content: AppStrings.goBackDescrption,
        noText: AppStrings.cancel,
        yesText: AppStrings.goBack,
        yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
      );

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        _confirmGoBack(context);
        return Future.value(false);
      },
      child: AppScaffold(
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        appBar: _appBar(context),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: <Widget>[
                const ChangePasswordForm(),
                Gap.v(AppSpacing.spaceUnit),
                 Align(child: ChangePasswordButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        leading: AppLeadingAppBarWidget(onTap: () => _confirmGoBack(context)),
        title: Text(
          AppStrings.resetPassword,
          style: TextStyle(
            fontWeight: AppFontWeight.semiBold,
            fontSize: 16,
          ),
        ),
      );
}
