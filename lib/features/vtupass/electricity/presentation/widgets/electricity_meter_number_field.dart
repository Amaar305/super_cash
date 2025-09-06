import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class ElectricityMeterNumberField extends StatefulWidget {
  const ElectricityMeterNumberField({super.key});

  @override
  State<ElectricityMeterNumberField> createState() =>
      _ElectricityMeterNumberFieldState();
}

class _ElectricityMeterNumberFieldState
    extends State<ElectricityMeterNumberField> {
  late final ElectricityCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ElectricityCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onDecoderFocused();
        }
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ElectricityCubit c) => c.state.status.isLoading,
    );
    final meterErrorMsg = context.select(
      (ElectricityCubit c) => c.state.meter.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.meterNumber,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          hintText: 'Enter ${AppStrings.meterNumber}',
          focusNode: _focusNode,
          prefixIcon: Icon(
            Icons.numbers_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          onChanged: (p0) => _debouncer.run(() => _cubit.onDecoderChanged(p0)),
          errorText: meterErrorMsg,
        ),
      ],
    );
  }
}
