import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';

class KycHomeAddressHouseNoField extends StatefulWidget {
  const KycHomeAddressHouseNoField({super.key});

  @override
  State<KycHomeAddressHouseNoField> createState() =>
      _KycHomeAddressHouseNoFieldState();
}

class _KycHomeAddressHouseNoFieldState
    extends State<KycHomeAddressHouseNoField> {
  late final KycHomeAddressCubit _cubit;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycHomeAddressCubit>();
    _controller = TextEditingController(text: _cubit.state.houseNo)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(KycHomeAddressHouseNoField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final val = _cubit.state.houseNo;
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
    _debouncer.run(() => _cubit.onHouseNoChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('House Number (optional)'),
        AppTextField.underlineBorder(
          hintText: 'e.g. 12B',
          prefixIcon: const Icon(
            Icons.tag_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          textInputAction: TextInputAction.next,
          textController: _controller,
        ),
      ],
    );
  }
}
