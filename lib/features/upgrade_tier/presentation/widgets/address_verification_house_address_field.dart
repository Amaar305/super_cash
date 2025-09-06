import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/app_prefix_icon.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AddressVerificationHouseAddressField extends StatefulWidget {
  const AddressVerificationHouseAddressField({super.key});

  @override
  State<AddressVerificationHouseAddressField> createState() =>
      _AddressVerificationHouseAddressFieldState();
}

class _AddressVerificationHouseAddressFieldState
    extends State<AddressVerificationHouseAddressField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final houseAddress = _cubit.state.houseAddress;
    _controller = TextEditingController(text: houseAddress.value)
      ..addListener(_onTextChanged);

    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onHouseAddressUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(AddressVerificationHouseAddressField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final houseAddress = _cubit.state.houseAddress;

    if (_controller.text != houseAddress.value) {
      _controller.text = houseAddress.value;
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
    final houseAddressErrMsg = context.select(
      (UpgradeTierCubit element) => element.state.houseAddress.errorMessage,
    );

    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.houseAddress),
        AppTextField.underlineBorder(
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: AppPrefixIcon(Icons.home_outlined),
          filled: Config.filled,
          textInputType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.addressCityAndState],
          hintText: "Enter ${AppStrings.houseAddress.toLowerCase()}",
          textController: _controller,
          errorText: houseAddressErrMsg,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onHouseAddressChanged(_controller.text.trim()));
  }
}
