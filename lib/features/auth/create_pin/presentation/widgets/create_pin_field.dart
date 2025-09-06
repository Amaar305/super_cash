import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/auth/create_pin/presentation/cubit/create_pin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class CreatePinField extends StatefulWidget {
  const CreatePinField({super.key});

  @override
  State<CreatePinField> createState() => _CreatePinFieldState();
}

class _CreatePinFieldState extends State<CreatePinField> {
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
    final isLoading = context.select(
      (CreatePinCubit cubit) => cubit.state.status.isLoading,
    );
    final showPin = context.select(
      (CreatePinCubit cubit) => cubit.state.showPin,
    );
    final pinError = context.select(
      (CreatePinCubit cubit) => cubit.state.newPin.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'Transaction PIN',
          style: TextStyle(fontSize: 12, fontWeight: AppFontWeight.semiBold),
        ),
        AppOtpForm(
          numberOfInputs: 4,
          enabled: !isLoading,
          obscured: showPin,
          onCompleted: (otp) {},
          onChange: (otp) => _debouncer.run(() => _cubit.onNewPinChanged(otp)),
        ),
        if (pinError != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pinError,
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
