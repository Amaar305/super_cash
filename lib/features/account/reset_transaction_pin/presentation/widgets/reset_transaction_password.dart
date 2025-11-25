import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';

import '../cubit/reset_transaction_pin_cubit.dart';

class ResetTransactionPassword extends StatefulWidget {
  const ResetTransactionPassword({super.key});

  @override
  State<ResetTransactionPassword> createState() =>
      _ResetTransactionPasswordState();
}

class _ResetTransactionPasswordState extends State<ResetTransactionPassword> {
  late final ResetTransactionPinCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ResetTransactionPinCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onPasswordUnfocused();
        }
      });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ResetTransactionPinCubit element) => element.state.status.isLoading,
    );

    final showPassword = context.select(
      (ResetTransactionPinCubit cubit) => cubit.state.showPassword,
    );
    final passwordErrorMessage = context.select(
      (ResetTransactionPinCubit cubit) => cubit.state.password.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          AppStrings.password,
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
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
