import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';

class KycHomeAddressCityField extends StatefulWidget {
  const KycHomeAddressCityField({super.key});

  @override
  State<KycHomeAddressCityField> createState() =>
      _KycHomeAddressCityFieldState();
}

class _KycHomeAddressCityFieldState extends State<KycHomeAddressCityField> {
  late final KycHomeAddressCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycHomeAddressCubit>();
    _controller = TextEditingController(text: _cubit.state.city.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) _cubit.onCityUnfocused();
      });
  }

  @override
  void didUpdateWidget(KycHomeAddressCityField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final val = _cubit.state.city.value;
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
    _debouncer.run(() => _cubit.onCityChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select(
      (KycHomeAddressCubit c) => c.state.city.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('City'),
        AppTextField.underlineBorder(
          hintText: 'Enter city',
          prefixIcon: const Icon(
            Icons.location_city_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: _focusNode,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          textController: _controller,
          errorText: error,
          errorMaxLines: 2,
        ),
      ],
    );
  }
}
