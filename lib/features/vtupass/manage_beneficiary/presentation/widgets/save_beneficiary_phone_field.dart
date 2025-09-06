import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../cubit/save_update_beneficiary_cubit.dart';

class SaveBeneficiaryPhoneField extends StatefulWidget {
  const SaveBeneficiaryPhoneField({super.key});

  @override
  State<SaveBeneficiaryPhoneField> createState() =>
      _SaveBeneficiaryPhoneFieldState();
}

class _SaveBeneficiaryPhoneFieldState extends State<SaveBeneficiaryPhoneField> {
  late final TextEditingController _nameController;
  late final FocusNode _phoneFocusNode;
  late final Debouncer _nameDebouncer;
  late final SaveUpdateBeneficiaryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SaveUpdateBeneficiaryCubit>();
    final phone = _cubit.state.phone.value;
    _nameController = TextEditingController(text: phone);
    _nameController.addListener(_onTextChanged);
    _phoneFocusNode = FocusNode()
      ..addListener(() {
        if (!_phoneFocusNode.hasFocus) {
          _cubit.onPhoneUnfocused();
        }
      });

    _nameDebouncer = Debouncer();
  }

  @override
  void didUpdateWidget(SaveBeneficiaryPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final phone = _cubit.state.phone.value;
    if (_nameController.text != phone) {
      _nameController.text = phone;
    }
  }

  void _onTextChanged() {
    _nameDebouncer.run(() {
      _cubit.onPhoneChanged(_nameController.text);
    });
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_onTextChanged)
      ..dispose();
    _phoneFocusNode.dispose();
    _nameDebouncer.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.status.isLoading,
    );

    final phoneError = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.phone.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.phoneNumber,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          textController: _nameController,
          prefixIcon: const Icon(
            Icons.phone_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          errorText: phoneError,
          focusNode: _phoneFocusNode,
          hintText: '090 000-000-0000',
          filled: Config.filled,
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
