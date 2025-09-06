import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataNetworkProvider extends StatelessWidget {
  const DataNetworkProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNetwork = context.select(
      (DataCubit cubit) => cubit.state.selectedNetwork,
    );
    final isLoading = context.select(
      (DataCubit cubit) => cubit.state.status.isLoading,
    );

    return AppNetworkProviderWidget(
      onNetworkSelect: isLoading
          ? null
          : context.read<DataCubit>().onNetworkChanged,
      selectedNetwork: selectedNetwork,
    );
  }
}
