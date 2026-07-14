import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/cubit/kyc_personal_information_cubit.dart';

class KycPersonalInfoFirstNameField extends StatefulWidget {
  const KycPersonalInfoFirstNameField({super.key});

  @override
  State<KycPersonalInfoFirstNameField> createState() =>
      _KycPersonalInfoFirstNameFieldState();
}

class _KycPersonalInfoFirstNameFieldState
    extends State<KycPersonalInfoFirstNameField> {
  late final KycPersonalInformationCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycPersonalInformationCubit>();
    _controller = TextEditingController(text: _cubit.state.firstName.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) _cubit.onFirstNameUnfocused();
      });
  }

  @override
  void didUpdateWidget(KycPersonalInfoFirstNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final val = _cubit.state.firstName.value;
    if (_controller.text != val) _controller.text = val;
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

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onFirstNameChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select(
      (KycPersonalInformationCubit c) => c.state.firstName.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('First Name'),
        AppTextField.underlineBorder(
          hintText: 'First Name',
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
          textController: _controller,
          errorText: error,
          errorMaxLines: 2,
        ),
      ],
    );
  }
}
