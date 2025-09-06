import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/features/account/change_transaction_pin/change_transaction_pin.dart';

class ChangeTransactionPinForm extends StatelessWidget {
  const ChangeTransactionPinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeTransactionPinCubit, ChangeTransactionPinState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,
        children: [
          ChangeTransactionPinCurrentPinField(),
          ChangeTransactionPinNewPinField(),
          ChangeTransactionPinConfirmPinField(),
        ],
      ),
    );
  }
}
