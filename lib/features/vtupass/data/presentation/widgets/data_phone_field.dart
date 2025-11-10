import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../widgets/widgets.dart';
import '../cubit/data_cubit.dart';

class DataPhoneField extends StatefulWidget {
  const DataPhoneField({super.key});

  @override
  State<DataPhoneField> createState() => _DataPhoneFieldState();
}

class _DataPhoneFieldState extends State<DataPhoneField> {
  late final DataCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DataCubit>();
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
  void didUpdateWidget(DataPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    final user = context.read<AppBloc>().state.user;

    if (user == AppUser.anonymous) return;
    _controller.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (DataCubit cubit) => cubit.state.status.isLoading,
    );
    final phoneErrorMessage = context.select(
      (DataCubit cubit) => cubit.state.phone.errorMessage,
    );
    final phone = context.select((DataCubit cubit) => cubit.state.phone.value);
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
