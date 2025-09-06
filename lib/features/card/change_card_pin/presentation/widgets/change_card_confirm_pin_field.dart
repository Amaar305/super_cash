import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class ChangeCardConfirmPinField extends StatefulWidget {
  const ChangeCardConfirmPinField({
    super.key,
  });

  @override
  State<ChangeCardConfirmPinField> createState() =>
      _ChangeCardConfirmPinFieldState();
}

class _ChangeCardConfirmPinFieldState extends State<ChangeCardConfirmPinField> {
  late final ChangeCardPinCubit _cubit;
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChangeCardPinCubit>();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((ChangeCardPinCubit cubit) => cubit.state.status.isLoading);

    final pinError = context.select(
        (ChangeCardPinCubit cubit) => cubit.state.confirmCardPin.errorMessage);

    final incompleteError = context.select(
        (ChangeCardPinCubit cubit) => cubit.state.confirmCardPinMessage);
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'Confim Card pin',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          onCompleted: (p0) {},
          onChange: (otp) => _debouncer.run(
            () => _cubit.onConfirmPinChanged(otp),
          ),
          enabled: !isLoading,
          errorText: pinError ?? incompleteError,
        ),
      ],
    );
  }
}
