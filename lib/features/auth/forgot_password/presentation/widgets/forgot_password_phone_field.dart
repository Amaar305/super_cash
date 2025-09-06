import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

class ForgotPasswordPhoneField extends StatefulWidget {
  const ForgotPasswordPhoneField({super.key});

  @override
  State<ForgotPasswordPhoneField> createState() =>
      _ForgotPasswordPhoneFieldState();
}

class _ForgotPasswordPhoneFieldState extends State<ForgotPasswordPhoneField> {
  late final ForgotPasswordCubit _cubit;
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onPhoneUnfocused();
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
    final phoneErrorMessage = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.phone.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.emailAddress),
        AppTextField.underlineBorder(
          hintText: 'Enter ${AppStrings.phoneNumber.toLowerCase()}',
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: const Icon(
            Icons.phone_outlined,
            size: 20,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          autofillHints: const [
            AutofillHints.telephoneNumber,
            AutofillHints.telephoneNumberDevice,
          ],
          errorText: phoneErrorMessage,
          onChanged: (v) => _debouncer.run(() => _cubit.onPhoneChanged(v)),
        ),
      ],
    );
  }
}
