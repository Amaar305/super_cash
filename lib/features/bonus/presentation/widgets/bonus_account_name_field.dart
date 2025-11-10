import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusAccountNameField extends StatefulWidget {
  const BonusAccountNameField({super.key});

  @override
  State<BonusAccountNameField> createState() => _BonusAccountNameFieldState();
}

class _BonusAccountNameFieldState extends State<BonusAccountNameField> {
  late final TextEditingController _controller;
  late final BonusCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<BonusCubit>();
    _controller = TextEditingController(text: _cubit.state.accountName.value)
      ..addListener(_onAccountNameChanged);
    _focusNode = FocusNode()..addListener(_onAccountNamefocused);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(BonusAccountNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_cubit.state.accountName.value != _controller.text) {
      _controller.text = _cubit.state.accountName.value;
    }
  }

  void _onAccountNameChanged() {
    _debouncer.run(() {
      _cubit.onAccountNameChanged(_controller.text);
    });
  }

  void _onAccountNamefocused() {
    if (!_focusNode.hasFocus) {
      _cubit.onAccountNameFocused();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onAccountNameChanged)
      ..dispose();
    _focusNode
      ..removeListener(_onAccountNamefocused)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountNameErrorMessage = context.select(
      (BonusCubit cubit) => cubit.state.accountName.errorMessage,
    );
    final isLoading = context.select(
      (BonusCubit cubit) => cubit.state.status.isLoading,
    );
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enter Account Name', style: poppinsTextStyle()),
        AppTextField.underlineBorder(
          hintText: 'Account Name',
          focusNode: _focusNode,
          prefixIcon: const Icon(
            Icons.person_outline,
            size: 24,
            color: AppColors.grey,
          ),
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.done,
          enabled: !isLoading,
          textController: _controller,
          errorText: accountNameErrorMessage,
        ),
      ],
    );
  }
}
