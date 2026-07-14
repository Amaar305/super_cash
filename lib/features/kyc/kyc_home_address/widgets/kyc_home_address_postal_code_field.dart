import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';

class KycHomeAddressPostalCodeField extends StatefulWidget {
  const KycHomeAddressPostalCodeField({super.key});

  @override
  State<KycHomeAddressPostalCodeField> createState() =>
      _KycHomeAddressPostalCodeFieldState();
}

class _KycHomeAddressPostalCodeFieldState
    extends State<KycHomeAddressPostalCodeField> {
  late final KycHomeAddressCubit _cubit;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycHomeAddressCubit>();
    _controller = TextEditingController(text: _cubit.state.postalCode)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(KycHomeAddressPostalCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final val = _cubit.state.postalCode;
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
    _debouncer.run(() => _cubit.onPostalCodeChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('Postal Code (optional)'),
        AppTextField.underlineBorder(
          hintText: 'e.g. 100001',
          prefixIcon: const Icon(
            Icons.markunread_mailbox_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.number,
          autofillHints: const [AutofillHints.postalCode],
          textController: _controller,
        ),
      ],
    );
  }
}
