import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DataGiveawayClaimPhoneField extends StatefulWidget {
  const DataGiveawayClaimPhoneField({super.key, required this.network});
  final String network;

  @override
  State<DataGiveawayClaimPhoneField> createState() =>
      _DataGiveawayClaimPhoneFieldState();
}

class _DataGiveawayClaimPhoneFieldState
    extends State<DataGiveawayClaimPhoneField> {
  late final DataGiveawayCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DataGiveawayCubit>();
    final phone = _cubit.state.phone;
    _controller = TextEditingController(text: phone.value)
      ..addListener(_onTextChanged);
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onPhoneUnfocused();
        }
      });
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onPhoneChanged(_controller.text.trim()));
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
  void didUpdateWidget(DataGiveawayClaimPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);

    final phone = _cubit.state.phone;

    if (_controller.text != phone.value) {
      _controller.text = phone.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (DataGiveawayCubit cubit) => cubit.state.status.isLoading,
    );

    final phoneErrMsg = context.select(
      (DataGiveawayCubit cubit) => cubit.state.phone.errorMessage,
    );
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle('Phone Number'),
        AppTextField.underlineBorder(
          focusNode: _focusNode,
          enabled: !isLoading,
          helperText: 'Make sure this number is ${widget.network}',
          prefixIcon: AppPrefixIcon(Icons.phone_outlined),
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.telephoneNumber],
          hintText: "Enter Phone Number",
          textController: _controller,
          errorText: phoneErrMsg,
        ),
      ],
    );
  }
}
