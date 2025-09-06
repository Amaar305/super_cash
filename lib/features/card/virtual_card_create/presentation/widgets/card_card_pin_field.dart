// ignore_for_file: deprecated_member_use

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../virtual_card_create.dart';

class CardCardPinField extends StatefulWidget {
  const CardCardPinField({super.key});

  @override
  State<CardCardPinField> createState() => _CardCardPinFieldState();
}

class _CardCardPinFieldState extends State<CardCardPinField> {
  late final CreateVirtualCardCubit _cubit;
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateVirtualCardCubit>();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.status.isLoading,
    );

    final pinError = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.cardPin.errorMessage,
    );
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.setCardPin,
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          enabled: !isLoading,

          // obscured: showPin,
          onCompleted: (otp) {},
          onChange: (otp) => _debouncer.run(() => _cubit.onCardPinChanged(otp)),
          errorText: pinError,
        ),
      ],
    );
  }
}
