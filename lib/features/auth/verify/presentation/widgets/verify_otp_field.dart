import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class VerifyOtpField extends StatefulWidget {
  const VerifyOtpField({super.key});

  @override
  State<VerifyOtpField> createState() => _VerifyOtpFieldState();
}

class _VerifyOtpFieldState extends State<VerifyOtpField> {
  final _debounce = Debouncer();
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (VerifyCubit element) => element.state.status.isLoading,
    );
    final otpErrorMsg = context.select(
      (VerifyCubit element) => element.state.otp.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text('Enter Code', style: context.bodySmall),
        AppOtpForm(
          enabled: !isLoading,
          errorText: otpErrorMsg,
          numberOfInputs: 4,
          onCompleted: (p0) {},
          onChange: (p0) =>
              _debounce.run(() => context.read<VerifyCubit>().onOtpChanged(p0)),
        ),
      ],
    );
  }
}
