import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ExamPinExamProvider extends StatelessWidget {
  ExamPinExamProvider({super.key});

  final exams = <ServiceProviderModel>[
    ServiceProviderModel(
      name: 'WAEC',
      icon: Assets.images.waec.image(),
      value: 'waec',
    ),
    ServiceProviderModel(
      name: 'NECO',
      icon: Assets.images.neco.image(),
      value: 'neco',
    ),
    ServiceProviderModel(
      name: 'NABTEB',
      icon: Assets.images.nabteb.image(),
      value: 'nabteb',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final isLoading = false;
    return AppServiceProviderWidget(
      label: AppStrings.paymentItem,
      showText: true,
      // onChanged: ,
      services: exams,
      isLoading: isLoading,
      selectedService: 'NECO',
    );
  }
}
