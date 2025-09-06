import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({super.key});

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  late final LoginCubit _cubit;
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onPasswordUnfocused();
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
      (LoginCubit cubit) => cubit.state.status.isLoading,
    );
    final showPassword = context.select(
      (LoginCubit cubit) => cubit.state.showPassword,
    );
    final passwordErrorMessage = context.select(
      (LoginCubit cubit) => cubit.state.password.errorMessage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.password),
        AppTextField.underlineBorder(
          hintText: 'Enter ${AppStrings.password.toLowerCase()}',
          prefixIcon: const Icon(
            Icons.lock_outline,
            size: 24,
            color: AppColors.grey,
          ),
          focusNode: _focusNode,
          filled: Config.filled,
          enabled: !isLoading,
          obscureText: showPassword,
          textInputAction: TextInputAction.done,
          errorText: passwordErrorMessage,
          errorMaxLines: 3,
          onChanged: (v) => _debouncer.run(() => _cubit.onPasswordChanged(v)),
          suffixIcon: Tappable.faded(
            backgroundColor: AppColors.transparent,
            onTap: isLoading ? null : _cubit.changePasswordVisibility,
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
