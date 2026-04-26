import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ProductAddressFullNameField extends StatefulWidget {
  const ProductAddressFullNameField({super.key});

  @override
  State<ProductAddressFullNameField> createState() =>
      _ProductAddressFullNameFieldState();
}

class _ProductAddressFullNameFieldState
    extends State<ProductAddressFullNameField> {
  late final ProductGiveawayCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductGiveawayCubit>();
    final fullName = _cubit.state.fullName;
    _controller = TextEditingController(text: fullName.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onFullNameUnfocused();
        }
      });
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onFullNameChanged(_controller.text.trim()));
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

  @override
  void didUpdateWidget(ProductAddressFullNameField oldWidget) {
    super.didUpdateWidget(oldWidget);

    final fullName = _cubit.state.fullName;

    if (_controller.text != fullName.value) {
      _controller.text = fullName.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ProductGiveawayCubit cubit) => cubit.state.status.isLoading,
    );

    final fullErrMsg = context.select(
      (ProductGiveawayCubit cubit) => cubit.state.fullName.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle('Full Name'),
        AppTextField.underlineBorder(
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: AppPrefixIcon(Icons.person_outlined),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.name],
          hintText: "Enter Full Name",
          textController: _controller,
          errorText: fullErrMsg,
        ),
      ],
    );
  }
}
