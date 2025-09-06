import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../cubit/change_transaction_pin_cubit.dart';

class ChangeTransactionPinNewPinField extends StatefulWidget {
  const ChangeTransactionPinNewPinField({super.key});

  @override
  State<ChangeTransactionPinNewPinField> createState() =>
      _ChangeTransactionPinNewPinFieldState();
}

class _ChangeTransactionPinNewPinFieldState
    extends State<ChangeTransactionPinNewPinField> {
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
          element.state.newPin.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'New PIN',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          onCompleted: (p0) {},
          onChange: (otp) => _debouncer.run(() => _cubit.onNewPinChanged(otp)),
          errorText: errorMsg,
          enabled: !isLoading,
        ),
      ],
    );
  }
}
