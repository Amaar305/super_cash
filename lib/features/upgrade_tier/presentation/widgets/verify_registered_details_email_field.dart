import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/app_prefix_icon.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class VerifyRegisteredDetailsEmailField extends StatefulWidget {
  const VerifyRegisteredDetailsEmailField({super.key});

  @override
  State<VerifyRegisteredDetailsEmailField> createState() =>
      _VerifyRegisteredDetailsEmailFieldState();
}

class _VerifyRegisteredDetailsEmailFieldState
    extends State<VerifyRegisteredDetailsEmailField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final email = context.read<UpgradeTierCubit>().state.email;
    _controller = TextEditingController(text: email.value)
      ..addListener(_onTextChanged);

    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onEmailUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(VerifyRegisteredDetailsEmailField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final email = _cubit.state.email;

    if (_controller.text != email.value) {
      _controller.text = email.value;
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailError = context.select(
      (UpgradeTierCubit cubit) => cubit.state.email.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.emailAddress),
        AppTextField.underlineBorder(
          filled: Config.filled,
          textInputType: TextInputType.emailAddress,
          focusNode: _focusNode,
          prefixIcon: AppPrefixIcon(Icons.email_outlined),
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          hintText: "Enter ${AppStrings.emailAddress.toLowerCase()}",
          errorText: emailError,
          enabled: false,
          textController: _controller,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onEmailChanged(_controller.text.trim()));
  }
}
