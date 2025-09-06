import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class LastNameField extends StatefulWidget {
  const LastNameField({super.key});

  @override
  State<LastNameField> createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<LastNameField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onLastNameUnfocused();
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
      (RegisterCubit cubit) => cubit.state.status.isLoading,
    );

    final lastNameError = context.select(
      (RegisterCubit cubit) => cubit.state.lastName.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.lastName),
        AppTextField.underlineBorder(
          hintText: AppStrings.lastName,
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
          onChanged: (v) => _debouncer.run(() => _cubit.onLastNameChanged(v)),
          errorText: lastNameError,
          errorMaxLines: 3,
        ),
        Text(
          AppStrings.lastnameInstruction,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
