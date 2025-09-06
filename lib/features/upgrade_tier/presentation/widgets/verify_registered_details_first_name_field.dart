import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class VerifyRegisteredDetailsFirstNameField extends StatefulWidget {
  const VerifyRegisteredDetailsFirstNameField({super.key});

  @override
  State<VerifyRegisteredDetailsFirstNameField> createState() =>
      _VerifyRegisteredDetailsFirstNameFieldState();
}

class _VerifyRegisteredDetailsFirstNameFieldState
    extends State<VerifyRegisteredDetailsFirstNameField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final firstName = _cubit.state.firstName;
    _controller = TextEditingController(text: firstName.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onFirstNameUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(VerifyRegisteredDetailsFirstNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final firstName = _cubit.state.firstName;

    if (_controller.text != firstName.value) {
      _controller.text = firstName.value;
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _focusNode.dispose();
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstNameError = context.select(
      (UpgradeTierCubit cubit) => cubit.state.firstName.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.firstName),
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
          enabled: false,
          textController: _controller,
          errorText: firstNameError,
          errorMaxLines: 3,
          helperText: 'Input your first name as in your Government ID',
          helperStyle: MonaSansTextStyle.label(),
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onFirstNameChanged(_controller.text.trim()));
  }
}
