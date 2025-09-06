import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../auth.dart';

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({super.key});

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onConfirmPasswordUnfocused();
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
    final isLoading = context.select(
      (RegisterCubit cubit) => cubit.state.status.isLoading,
    );
    final showPassword = context.select(
      (RegisterCubit cubit) => cubit.state.showConfirmPassword,
    );
    final passwordError = context.select(
      (RegisterCubit cubit) => cubit.state.confirmPassword.errorMessage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.passwordConfirmation),
        AppTextField.underlineBorder(
          hintText: AppStrings.passwordConfirmation,
          prefixIcon: const Icon(
            Icons.lock_outline,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: _focusNode,
          errorText: passwordError,
          enabled: !isLoading,
          textInputAction: TextInputAction.done,
          obscureText: !showPassword,
          onChanged: (v) =>
              _debouncer.run(() => _cubit.onConfirmPasswordChanged(v)),
          suffixIcon: Tappable.faded(
            backgroundColor: AppColors.transparent,
            onTap: () => isLoading
                ? null
                : _cubit.changePasswordVisibility(confirmPass: true),
            child: Icon(
              !showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 20,
              color: context
                  .customAdaptiveColor(dark: AppColors.grey)
                  .withValues(alpha: isLoading ? .4 : 1),
            ),
          ),
        ),
      ],
    );
  }
}
