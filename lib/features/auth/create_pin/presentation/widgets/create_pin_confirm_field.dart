import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../auth.dart';

class CreatePinConfirmField extends StatefulWidget {
  const CreatePinConfirmField({super.key});

  @override
  State<CreatePinConfirmField> createState() => _CreatePinConfirmFieldState();
}

class _CreatePinConfirmFieldState extends State<CreatePinConfirmField> {
  late final CreatePinCubit _cubit;
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreatePinCubit>();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((CreatePinCubit cubit) => cubit.state.status.isLoading);
    final showPin =
        context.select((CreatePinCubit cubit) => cubit.state.showPin);
    final pinError = context
        .select((CreatePinCubit cubit) => cubit.state.confirmPin.errorMessage);
    final incompleteError =
        context.select((CreatePinCubit cubit) => cubit.state.confirmPinMessage);
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'Confirm PIN',
          style: TextStyle(fontSize: 12, fontWeight: AppFontWeight.semiBold),
        ),
        AppOtpForm(
          numberOfInputs: 4,
          enabled: !isLoading,
          obscured: showPin,
          onCompleted: (otp) {},
          onChange: (otp) => _debouncer.run(
            () => _cubit.onConfirmPinChanged(otp),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pinError ?? incompleteError,
              style: TextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.semiBold,
                color: AppColors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
