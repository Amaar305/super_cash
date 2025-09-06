import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class VerifyRegisteredDetailsPhoneNumberField extends StatefulWidget {
  const VerifyRegisteredDetailsPhoneNumberField({super.key});

  @override
  State<VerifyRegisteredDetailsPhoneNumberField> createState() =>
      _VerifyRegisteredDetailsPhoneNumberFieldState();
}

class _VerifyRegisteredDetailsPhoneNumberFieldState
    extends State<VerifyRegisteredDetailsPhoneNumberField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final phone = _cubit.state.phone;
    _controller = TextEditingController(text: phone.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onPhoneUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(
    covariant VerifyRegisteredDetailsPhoneNumberField oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    final phone = _cubit.state.phone;

    if (_controller.text != phone.value) {
      _controller.text = phone.value;
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
    final phoneError = context.select(
      (UpgradeTierCubit cubit) => cubit.state.phone.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.phoneNumber),
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
          enabled: false,
          errorText: phoneError,
          errorMaxLines: 3,
          textController: _controller,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onPhoneChanged(_controller.text.trim()));
  }
}
