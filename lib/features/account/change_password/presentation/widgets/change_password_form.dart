import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/features/account/change_password/presentation/cubit/change_password_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }
      },
      child: Column(
        spacing: AppSpacing.xxlg,
        children: [
          ChangeCurrentPasswordField(),
          ChangePasswordNewPasswordField(),
          ChangePasswordConfirmPasswordField(),
        ],
      ),
    );
  }
}
