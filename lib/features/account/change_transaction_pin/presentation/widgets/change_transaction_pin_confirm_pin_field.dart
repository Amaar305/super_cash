import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../cubit/change_transaction_pin_cubit.dart';

class ChangeTransactionPinConfirmPinField extends StatefulWidget {
  const ChangeTransactionPinConfirmPinField({super.key});

  @override
  State<ChangeTransactionPinConfirmPinField> createState() =>
      _ChangeTransactionPinConfirmPinFieldState();
}

class _ChangeTransactionPinConfirmPinFieldState
    extends State<ChangeTransactionPinConfirmPinField> {
  late final ChangeTransactionPinCubit _cubit;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChangeTransactionPinCubit>();
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
      (ChangeTransactionPinCubit element) => element.state.status.isLoading,
    );
    final errorMsg = context.select(
      (ChangeTransactionPinCubit element) =>
          element.state.confirmPin.errorMessage,
    );
    final dontMatchError = context.select(
      (ChangeTransactionPinCubit element) => element.state.confirmPinMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'Confirm PIN',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          onCompleted: (p0) {},
          onChange: (otp) =>
              _debouncer.run(() => _cubit.onConfirmPinChanged(otp)),
          errorText: errorMsg ?? dontMatchError,
          enabled: !isLoading,
        ),
      ],
    );
  }
}
