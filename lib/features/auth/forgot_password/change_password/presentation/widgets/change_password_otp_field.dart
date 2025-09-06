import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../../core/app_strings/app_string.dart';
import '../../../../auth.dart';

class ChangePasswordOtpField extends StatefulWidget {
  const ChangePasswordOtpField({super.key});

  @override
  State<ChangePasswordOtpField> createState() => _ChangePasswordOtpFieldState();
}

class _ChangePasswordOtpFieldState extends State<ChangePasswordOtpField> {
  late Debouncer _debouncer;
  final _focusNode = FocusNode();
  late final ChangePasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
    _cubit = context.read<ChangePasswordCubit>()..resetState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onOtpUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpError = context.select(
      (ChangePasswordCubit cubit) => cubit.state.otp.errorMessage,
    );

    final isLoading = context.select(
      (ChangePasswordCubit cubit) => cubit.state.status.isLoading,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.code),
        AppTextField.underlineBorder(
          hintText: AppStrings.code,
          prefixIcon: const Icon(
            Icons.password_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: _focusNode,
          enabled: !isLoading,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          autofillHints: const [AutofillHints.oneTimeCode],
          onChanged: (v) => _debouncer.run(() => _cubit.onOtpChanged(v)),
          errorText: otpError,
          errorMaxLines: 3,
        ),
      ],
    );
  }
}
