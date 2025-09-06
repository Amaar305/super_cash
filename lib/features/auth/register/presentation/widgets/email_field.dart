import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../auth.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
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
      (RegisterCubit cubit) => cubit.state.status.isLoading,
    );
    final emailError = context.select(
      (RegisterCubit cubit) => cubit.state.email.errorMessage,
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
            size: 20,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          enabled: !isLoading,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          onChanged: (v) => _debouncer.run(() => _cubit.onEmailChanged(v)),
          errorText: emailError,
        ),
      ],
    );
  }
}
