import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../auth.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({super.key});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
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
      (RegisterCubit cubit) => cubit.state.status.isLoading,
    );

    final phoneError = context.select(
      (RegisterCubit cubit) => cubit.state.phone.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.phoneNumber),
        AppTextField.underlineBorder(
          hintText: 'Enter ${AppStrings.phoneNumber.toLowerCase()}',
          prefixIcon: const Icon(
            Icons.phone_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          enabled: !isLoading,
          errorText: phoneError,
          errorMaxLines: 3,
          onChanged: (p0) => _cubit.onPhoneChanged(p0),
        ),
      ],
    );
  }
}
