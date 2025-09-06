import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/app.dart';
import '../../../auth.dart';

class CreatePinForm extends StatelessWidget {
  const CreatePinForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePinCubit, CreatePinState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(
              description: state.message,
            ),
            clearIfQueue: true,
          );
        } else if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(
              description: state.response?['message'],
            ),
            clearIfQueue: true,
          );
          context.pushReplacement(AppRoutes.dashboard);
        }
      },
      child: Column(
        spacing: AppSpacing.xxxlg,
        children: [
          CreatePinField(),
          CreatePinConfirmField(),
        ],
      ),
    );
  }
}
