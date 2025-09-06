import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

class LoginEmailField extends StatefulWidget {
  const LoginEmailField({super.key});

  @override
  State<LoginEmailField> createState() => _LoginEmailFieldState();
}

class _LoginEmailFieldState extends State<LoginEmailField> {
  late final LoginCubit _cubit;
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
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
      (LoginCubit cubit) => cubit.state.status.isLoading,
    );
    final emailErrorMessage = context.select(
      (LoginCubit cubit) => cubit.state.email.errorMessage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.emailAddress),
        AppTextField.underlineBorder(
          hintText: AppStrings.emailAddress,
          focusNode: _focusNode,
          prefixIcon: const Icon(
            Icons.email_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          enabled: !isLoading,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          onChanged: (v) => _debouncer.run(() => _cubit.onEmailChanged(v)),
          errorText: emailErrorMessage,
        ),
      ],
    );
  }
}
