import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';

import '../../../../../app/app.dart';
import '../../../auth.dart';

class CreatePinForm extends StatelessWidget {
  const CreatePinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePinCubit, CreatePinState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        } else if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(title: state.response?['message']),
            clearIfQueue: true,
          );
          final user = context.read<AppCubit>().state.user ?? AppUser.anonymous;
          context.read<AppCubit>().userLoggedIn(
            user.copyWith(transactionPin: !user.transactionPin),
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xxxlg,
        children: [CreatePinField(), CreatePinConfirmField()],
      ),
    );
  }
}
