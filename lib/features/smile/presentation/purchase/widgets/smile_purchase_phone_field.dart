import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

class SmilePurchasePhoneField extends StatefulWidget {
  const SmilePurchasePhoneField({super.key});

  @override
  State<SmilePurchasePhoneField> createState() =>
      _SmilePurchasePhoneFieldState();
}

class _SmilePurchasePhoneFieldState extends State<SmilePurchasePhoneField> {
  late final SmilePurchaseCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SmilePurchaseCubit>();
    _debouncer = Debouncer();
    _controller = TextEditingController(text: _cubit.state.phone.value)
      ..addListener(_onTextChanged);
    _focusNode = FocusNode()..addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onPhoneChanged(_controller.text));
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) _cubit.onPhoneFocused();
  }

  @override
  void didUpdateWidget(SmilePurchasePhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final phoneValue = _cubit.state.phone.value;
    if (_controller.text != phoneValue) _controller.text = phoneValue;
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onForMyselfTapped() {
    final user = context.read<AppCubit>().state.user;
    if (user == null || user.isAnonymous) return;
    _controller.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SmilePurchaseCubit cubit) => cubit.state.status.isLoading,
    );
    final phoneErrorMessage = context.select(
      (SmilePurchaseCubit cubit) => cubit.state.phone.errorMessage,
    );
    final phone = context.select(
      (SmilePurchaseCubit cubit) => cubit.state.phone.value,
    );

    _controller.text = phone;

    return VtuBeneficiaryPhoneNumberField(
      focusNode: _focusNode,
      isLoading: isLoading,
      onForMyselfTapped: _onForMyselfTapped,
      phoneErrorMessage: phoneErrorMessage,
      textController: _controller,
    );
  }
}
