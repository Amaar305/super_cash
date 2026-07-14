import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/cubit/kyc_personal_information_cubit.dart';

class KycPersonalInfoMiddleNameField extends StatefulWidget {
  const KycPersonalInfoMiddleNameField({super.key});

  @override
  State<KycPersonalInfoMiddleNameField> createState() =>
      _KycPersonalInfoMiddleNameFieldState();
}

class _KycPersonalInfoMiddleNameFieldState
    extends State<KycPersonalInfoMiddleNameField> {
  late final KycPersonalInformationCubit _cubit;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycPersonalInformationCubit>();
    _controller = TextEditingController(text: _cubit.state.middleName)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(KycPersonalInfoMiddleNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final val = _cubit.state.middleName;
    if (_controller.text != val) _controller.text = val;
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onMiddleNameChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('Middle Name (optional)'),
        AppTextField.underlineBorder(
          hintText: 'Middle Name',
          prefixIcon: const Icon(
            Icons.person_outline,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          textController: _controller,
        ),
      ],
    );
  }
}
