import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class ChangeCardNewPinField extends StatefulWidget {
  const ChangeCardNewPinField({
    super.key,
  });

  @override
  State<ChangeCardNewPinField> createState() => _ChangeCardNewPinFieldState();
}

class _ChangeCardNewPinFieldState extends State<ChangeCardNewPinField> {
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
    final isLoading =
        context.select((ChangeCardPinCubit cubit) => cubit.state.status.isLoading);

    final pinError = context
        .select((ChangeCardPinCubit cubit) => cubit.state.newCardPin.errorMessage);
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'New Card pin',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          onCompleted: (p0) {},
          onChange: (otp) => _debouncer.run(
            () => _cubit.onNewCardPinChanged(otp),
          ),
          enabled: !isLoading,
          errorText: pinError,
        ),
      ],
    );
  }
}
