import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';

class KycHomeAddressStreetField extends StatefulWidget {
  const KycHomeAddressStreetField({super.key});

  @override
  State<KycHomeAddressStreetField> createState() =>
      _KycHomeAddressStreetFieldState();
}

class _KycHomeAddressStreetFieldState extends State<KycHomeAddressStreetField> {
  late final KycHomeAddressCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycHomeAddressCubit>();
    _controller = TextEditingController(text: _cubit.state.address.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) _cubit.onAddressUnfocused();
      });
  }

  @override
  void didUpdateWidget(KycHomeAddressStreetField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final val = _cubit.state.address.value;
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
    _debouncer.run(() => _cubit.onAddressChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select(
      (KycHomeAddressCubit c) => c.state.address.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('Street Address'),
        AppTextField.underlineBorder(
          hintText: 'Enter street address',
          prefixIcon: const Icon(
            Icons.home_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: _focusNode,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.streetAddress,
          autofillHints: const [AutofillHints.streetAddressLine1],
          textController: _controller,
          maxLines: 2,
          errorText: error,
          errorMaxLines: 2,
        ),
      ],
    );
  }
}
