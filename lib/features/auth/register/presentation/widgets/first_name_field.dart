import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../auth.dart';

class FirstNameField extends StatefulWidget {
  const FirstNameField({super.key});

  @override
  State<FirstNameField> createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onFirstNameUnfocused();
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

    final firstNameError = context.select(
      (RegisterCubit cubit) => cubit.state.firstName.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.firstName),
        AppTextField.underlineBorder(
          hintText: AppStrings.firstName,
          prefixIcon: const Icon(
            Icons.person_outline,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: _focusNode,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.givenName],
          enabled: !isLoading,
          onChanged: (v) => _debouncer.run(() => _cubit.onFirstNameChanged(v)),
          errorText: firstNameError,
          errorMaxLines: 3,
        ),
        Text(
          AppStrings.nameInstruction,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
