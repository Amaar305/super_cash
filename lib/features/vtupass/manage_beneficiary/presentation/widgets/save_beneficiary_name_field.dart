import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../cubit/save_update_beneficiary_cubit.dart';

class SaveBeneficiaryNameField extends StatefulWidget {
  const SaveBeneficiaryNameField({super.key});

  @override
  State<SaveBeneficiaryNameField> createState() =>
      _SaveBeneficiaryNameFieldState();
}

class _SaveBeneficiaryNameFieldState extends State<SaveBeneficiaryNameField> {
  late final TextEditingController _nameController;
  late final FocusNode _nameFocusNode;
  late final Debouncer _nameDebouncer;
  late final SaveUpdateBeneficiaryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SaveUpdateBeneficiaryCubit>();
    final name = _cubit.state.name.value;
    _nameController = TextEditingController(text: name);
    _nameController.addListener(_onTextChanged);
    _nameFocusNode = FocusNode()
      ..addListener(() {
        if (!_nameFocusNode.hasFocus) {
          _cubit.onFirstNameUnfocused();
        }
      });

    _nameDebouncer = Debouncer();
  }

  @override
  void didUpdateWidget(SaveBeneficiaryNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final name = _cubit.state.name.value;
    if (_nameController.text != name) {
      _nameController.text = name;
    }
  }

  void _onTextChanged() {
    _nameDebouncer.run(() {
      _cubit.onFirstNameChanged(_nameController.text);
    });
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_onTextChanged)
      ..dispose();
    _nameFocusNode.dispose();
    _nameDebouncer.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.status.isLoading,
    );

    final nameError = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.name.errorMessage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.userName,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          prefixIcon: const Icon(
            Icons.person_outline,
            size: 24,
            color: AppColors.grey,
          ),
          textController: _nameController,
          hintText: AppStrings.enterName,
          filled: Config.filled,
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          errorText: nameError,
          focusNode: _nameFocusNode,
        ),
      ],
    );
  }
}
