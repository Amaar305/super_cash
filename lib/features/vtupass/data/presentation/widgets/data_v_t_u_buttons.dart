import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataVTUButtons extends StatelessWidget {
  const DataVTUButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((DataCubit c) => c.state.status.isLoading);
    return VTUActionButtons(
      isLoading: isLoading,
      onContactPicked: (newValue) =>
          context.read<DataCubit>().onPhoneChanged(newValue),
      onNumberPasted: (newValue) =>
          context.read<DataCubit>().onPhoneChanged(newValue),
    );
  }
}
