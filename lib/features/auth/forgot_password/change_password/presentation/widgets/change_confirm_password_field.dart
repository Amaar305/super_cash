import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../../core/app_strings/app_string.dart';
import '../../../../auth.dart';

class ChangeConfirmPasswordField extends StatefulWidget {
  const ChangeConfirmPasswordField({super.key});

  @override
  State<ChangeConfirmPasswordField> createState() =>
      _ChangeConfirmPasswordFieldState();
}

class _ChangeConfirmPasswordFieldState
    extends State<ChangeConfirmPasswordField> {
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
    final passwordError = context.select(
      (ChangePasswordCubit cubit) => cubit.state.confirmPassword.errorMessage,
    );
    final passwordConfirmError = context.select(
      (ChangePasswordCubit cubit) => cubit.state.confirmPasswordError ?? '',
    );
    final showPassword = context.select(
      (ChangePasswordCubit cubit) => cubit.state.showConfirmPassword,
    );
    final isLoading = context.select(
      (ChangePasswordCubit cubit) => cubit.state.status.isLoading,
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
          enabled: !isLoading,
          obscureText: !showPassword,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          autofillHints: const [AutofillHints.password],
          onChanged: (v) =>
              _debouncer.run(() => _cubit.onConfirmPasswordChanged(v)),
          errorText: passwordConfirmError.isNotEmpty
              ? passwordConfirmError
              : passwordError,
          suffixIcon: Tappable.faded(
            backgroundColor: AppColors.transparent,
            onTap: () => isLoading
                ? null
                : _cubit.changePasswordVisibility(confirmPass: true),
            child: Icon(
              !showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: AppSize.iconSizeSmall + 2,
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
