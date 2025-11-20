import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';

import '../../../widgets/widgets.dart';
import '../presentation.dart';

class CablePhoneField extends StatefulWidget {
  const CablePhoneField({super.key});

  @override
  State<CablePhoneField> createState() => _CablePhoneFieldState();
}

class _CablePhoneFieldState extends State<CablePhoneField> {
  late final CableCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CableCubit>();
    _debouncer = Debouncer();
    final phoneValue = _cubit.state.phone.value;
    _controller = TextEditingController(text: phoneValue)
      ..addListener(_onTextChanged);
    _focusNode = FocusNode()..addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onPhoneChanged(_controller.text));
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      _cubit.onPhoneFocused();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final phoneValue = _cubit.state.phone.value;

    if (_controller.text != phoneValue) {
      _controller.text = phoneValue;
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _focusNode.dispose();
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
      (CableCubit cubit) => cubit.state.status.isLoading,
    );
    final phoneErrorMessage = context.select(
      (CableCubit cubit) => cubit.state.phone.errorMessage,
    );

    return VtuBeneficiaryPhoneNumberField(
      focusNode: _focusNode,
      isLoading: isLoading,
      onForMyselfTapped: _onForMyselfTapped,
      phoneErrorMessage: phoneErrorMessage,
      textController: _controller,
    );
  }
}
