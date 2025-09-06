import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../app/app.dart';
import '../../../../../../core/app_strings/app_string.dart';
import '../../../../auth.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  void initState() {
    super.initState();
    context.read<ChangePasswordCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ChangePasswordCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(
              title: changePasswordStatusMessage[state.status]!.title,
              description:
                  changePasswordStatusMessage[state.status]?.description,
            ),
            clearIfQueue: true,
          );
        } else if (state.status.isSuccess) {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            enableDrag: false,
            builder: (context) => ResetPasswordBottomSheet(
              successMsg: state.response?['message'],
            ),
          );
        }
      },
      listenWhen: (p, c) => p.status != c.status,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xxlg / 2,
        children: <Widget>[
          const ChangePasswordOtpField(),
          const ChangePasswordField(),
          const ChangeConfirmPasswordField(),
        ],
      ),
    );
  }
}

class ResetPasswordBottomSheet extends StatelessWidget {
  const ResetPasswordBottomSheet({
    super.key,
    this.successMsg,
  });

  final String? successMsg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.38,
      child: AppConstrainedScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceUnit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSpacing.md,
            children: [
              Gap.v(AppSpacing.sm),
              Assets.images.circleCheck.image(
                width: 77,
                height: 77,
              ),
              Text(
                AppStrings.passwordReset,
                style: context.titleMedium,
              ),
              Text(
                successMsg ?? AppStrings.passwordResetSuccess,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFontWeight.extraLight,
                ),
              ),
              Gap.v(AppSpacing.spaceUnit / 2),
              PrimaryButton(
                isLoading: false,
                label: 'Done',
                onPressed: () => context.pushReplacement(AppRoutes.auth),
              )
            ],
          ),
        ),
      ),
    );
  }
}
