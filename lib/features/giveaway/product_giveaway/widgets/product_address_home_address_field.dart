import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/product_giveaway/cubit/product_giveaway_cubit.dart';

class ProductAddressHomeAddressField extends StatefulWidget {
  const ProductAddressHomeAddressField({super.key});

  @override
  State<ProductAddressHomeAddressField> createState() =>
      _AddressVerificationHouseAddressFieldState();
}

class _AddressVerificationHouseAddressFieldState
    extends State<ProductAddressHomeAddressField> {
  late final ProductGiveawayCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductGiveawayCubit>();
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
  void didUpdateWidget(ProductAddressHomeAddressField oldWidget) {
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
      (ProductGiveawayCubit element) => element.state.status.isLoading,
    );
    final houseAddressErrMsg = context.select(
      (ProductGiveawayCubit element) => element.state.houseAddress.errorMessage,
    );

    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.houseAddress),
        AppTextField.underlineBorder(
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: AppPrefixIcon(Icons.home_outlined),
          textInputType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
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
