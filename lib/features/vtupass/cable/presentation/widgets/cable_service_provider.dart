import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/widgets/app_service_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class CableServiceProvider extends StatefulWidget {
  const CableServiceProvider({super.key});

  @override
  State<CableServiceProvider> createState() => _CableServiceProviderState();
}

class _CableServiceProviderState extends State<CableServiceProvider> {
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  final List<ServiceProviderModel> services = [
    ServiceProviderModel(
      name: 'DSTV',
      icon: Assets.images.dstv.image(),
      value: 'dstv',
    ),
    ServiceProviderModel(
      name: 'GOtv',
      icon: Assets.images.gotv.image(),
      value: 'gotv',
    ),
    ServiceProviderModel(
      name: 'Startimes',
      icon: Assets.images.starttime.image(),
      value: 'startimes',
    ),
    ServiceProviderModel(
      name: 'ShowMax',
      icon: Assets.images.showmax.image(),
      value: 'showmax',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedProvider = context.select(
      (CableCubit cubit) => cubit.state.selectedProvider,
    );
    final isLoading = context.select(
      (CableCubit cubit) => cubit.state.status.isLoading,
    );

    return AppServiceProviderWidget(
      label: AppStrings.availableTvCable,
      onChanged: isLoading
          ? null
          : (val) => _debouncer.run(
              () => context.read<CableCubit>().onProviderChanged(val.name),
            ),
      services: services,
      selectedService: selectedProvider,
    );
  }
}
