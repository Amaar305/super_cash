import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

class ForgotPasswordEmailField extends StatefulWidget {
  const ForgotPasswordEmailField({super.key});

  @override
  State<ForgotPasswordEmailField> createState() =>
      _ForgotPasswordEmailFieldState();
}

class _ForgotPasswordEmailFieldState extends State<ForgotPasswordEmailField> {
  late final ForgotPasswordCubit _cubit;
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onEmailUnfocused();
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
      (ForgotPasswordCubit cubit) => cubit.state.status.isLoading,
    );
    final emailErrorMessage = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.email.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.emailAddress),
        AppTextField.underlineBorder(
          hintText: 'Enter ${AppStrings.emailAddress.toLowerCase()}',
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: const Icon(
            Icons.email_outlined,
            size: 20,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          errorText: emailErrorMessage,
          onChanged: (v) => _debouncer.run(() => _cubit.onEmailChanged(v)),
        ),
      ],
    );
  }
}
