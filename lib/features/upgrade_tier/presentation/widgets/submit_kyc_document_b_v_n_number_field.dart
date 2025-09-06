import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class SubmitKycDocumentBVNNumberField extends StatefulWidget {
  const SubmitKycDocumentBVNNumberField({super.key});

  @override
  State<SubmitKycDocumentBVNNumberField> createState() =>
      _SubmitKycDocumentBVNNumberFieldState();
}

class _SubmitKycDocumentBVNNumberFieldState
    extends State<SubmitKycDocumentBVNNumberField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final bvn = _cubit.state.bvn;
    _controller = TextEditingController(text: bvn.value)
      ..addListener(_onTextChanged);

    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onBvnUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(SubmitKycDocumentBVNNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bvn = _cubit.state.bvn;

    if (_controller.text != bvn.value) {
      _controller.text = bvn.value;
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
    final isLoading = context.select(
      (UpgradeTierCubit element) => element.state.status.isLoading,
    );
    final bvnErrMsg = context.select(
      (UpgradeTierCubit element) => element.state.bvn.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.bvnNumber),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          focusNode: _focusNode,
          prefixIcon: AppPrefixIcon(Icons.verified_user_outlined),
          filled: Config.filled,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          hintText: "Enter ${AppStrings.bvnNumber.toLowerCase()}",
          textController: _controller,
          errorText: bvnErrMsg,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onBvnChanged(_controller.text.trim()));
  }
}
