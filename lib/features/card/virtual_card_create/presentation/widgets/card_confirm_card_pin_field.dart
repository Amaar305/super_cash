import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../virtual_card_create.dart';

class CardConfirmCardPinField extends StatefulWidget {
  const CardConfirmCardPinField({super.key});

  @override
  State<CardConfirmCardPinField> createState() =>
      _CardConfirmCardPinFieldState();
}

class _CardConfirmCardPinFieldState extends State<CardConfirmCardPinField> {
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
    // final showPin = context.select(
    //   (CreateVirtualCardCubit cubit) => cubit.state.showPin,
    // );
    final pinError = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.confirmCardPin.errorMessage,
    );
    final incompleteError = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.confirmCardPinMessage,
    );
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.confirmCardPin,
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppOtpForm(
          enabled: !isLoading,
          // obscured: showPin,
          onCompleted: (otp) {},
          onChange: (otp) =>
              _debouncer.run(() => _cubit.onConfirmPinChanged(otp)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pinError ?? incompleteError,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
