import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../cubit/change_password_cubit.dart';

class ChangePasswordConfirmPasswordField extends StatefulWidget {
  const ChangePasswordConfirmPasswordField({super.key});

  @override
  State<ChangePasswordConfirmPasswordField> createState() =>
      _ChangePasswordConfirmPasswordFieldState();
}

class _ChangePasswordConfirmPasswordFieldState
    extends State<ChangePasswordConfirmPasswordField> {
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final ChangePasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChangePasswordCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onConfirmPasswordUnfocused();
        }
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _debouncer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ChangePasswordCubit cubit) => cubit.state.status.isLoading,
    );
    final errorMessage = context.select(
      (ChangePasswordCubit cubit) => cubit.state.confirmPassword.errorMessage,
    );
    final doesNotMatchedMessage = context.select(
      (ChangePasswordCubit cubit) => cubit.state.doesNotMatchedMessage,
    );
    final showConfirmPassword = context.select(
      (ChangePasswordCubit cubit) => cubit.state.showConfirmPassword,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Confirm Password',
          style: poppinsTextStyle(fontSize: AppSpacing.md),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          focusNode: _focusNode,
          hintText: 'Enter confirm password',
          prefixIcon: const Icon(
            Icons.lock_outline,
            size: 24,
            color: AppColors.grey,
          ),
          onChanged: (val) =>
              _debouncer.run(() => _cubit.onConfirmPasswordChanged(val)),
          errorText: errorMessage,
          obscureText: !showConfirmPassword,
          suffixIcon: Tappable.faded(
            onTap: isLoading ? null : _cubit.changeConfirmPasswordObsecure,
            backgroundColor: AppColors.transparent,
            child: Icon(
              !showConfirmPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 20,
              color: context
                  .customAdaptiveColor(dark: AppColors.grey)
                  .withValues(alpha: isLoading ? .4 : 1),
            ),
          ),
        ),
        if (doesNotMatchedMessage != null && doesNotMatchedMessage.isNotEmpty)
          Text(
            doesNotMatchedMessage,
            style: context.bodySmall?.copyWith(color: AppColors.red),
          ),
      ],
    );
  }
}
