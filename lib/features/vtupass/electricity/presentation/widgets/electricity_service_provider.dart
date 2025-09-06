import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/widgets/app_service_provider_widget.dart';
import 'package:flutter/material.dart';

class ElectricityServiceProvider extends StatelessWidget {
  ElectricityServiceProvider({super.key});

  final List<ServiceProviderModel> services = [
    ServiceProviderModel(
      name: 'DSTV',
      icon: Assets.images.dstv.image(),
      value: 'dstv',
    ),
    ServiceProviderModel(
      name: 'Startimes',
      icon: Assets.images.starttime.image(),
      value: 'startimes',
    ),
    ServiceProviderModel(
      name: 'ShowMax',
      icon: Assets.images.dstv.image(),
      value: 'showmax',
    ),
    ServiceProviderModel(
      name: 'GOtv',
      icon: Assets.images.gotv.image(),
      value: 'gotv',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppServiceProviderWidget(
      label: AppStrings.electricityProvider,
      onChanged: (d) {},
      services: services,
      selectedService: '',
    );
  }
}
