import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../cubit/reset_transaction_pin_cubit.dart';

class ResetTransactionConfirmPin extends StatefulWidget {
  const ResetTransactionConfirmPin({super.key});

  @override
  State<ResetTransactionConfirmPin> createState() =>
      _ResetTransactionConfirmPinState();
}

class _ResetTransactionConfirmPinState
    extends State<ResetTransactionConfirmPin> {
  late final ResetTransactionPinCubit _cubit;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ResetTransactionPinCubit>();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ResetTransactionPinCubit element) => element.state.status.isLoading,
    );
    final error = context.select(
      (ResetTransactionPinCubit element) =>
          element.state.confirmPin.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,

      children: [
        Text(
          'Confirm Pin',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          enabled: !isLoading,
          errorText: error,
          onCompleted: (otp) {},
          onChange: (otp) =>
              _debouncer.run(() => _cubit.onConfirmPinChanged(otp)),
        ),
      ],
    );
  }
}
