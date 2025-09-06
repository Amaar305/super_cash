import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class VerifyRegisteredDetailsLastNameField extends StatefulWidget {
  const VerifyRegisteredDetailsLastNameField({super.key});

  @override
  State<VerifyRegisteredDetailsLastNameField> createState() =>
      _VerifyRegisteredDetailsLastNameFieldState();
}

class _VerifyRegisteredDetailsLastNameFieldState
    extends State<VerifyRegisteredDetailsLastNameField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final lastName = _cubit.state.lastName;
    _controller = TextEditingController(text: lastName.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onLastNameUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(VerifyRegisteredDetailsLastNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final lastName = _cubit.state.lastName;

    if (_controller.text != lastName.value) {
      _controller.text = lastName.value;
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
    final lastNameError = context.select(
      (UpgradeTierCubit cubit) => cubit.state.lastName.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.lastName),
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
          enabled: false,
          textController: _controller,
          errorText: lastNameError,
          errorMaxLines: 3,
          helperText: 'Input your last name as in your Government ID',
          helperStyle: MonaSansTextStyle.label(),
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onLastNameChanged(_controller.text.trim()));
  }
}
