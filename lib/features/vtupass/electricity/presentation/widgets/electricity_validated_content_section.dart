import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/common/widgets/widgets.dart';
import 'package:super_cash/features/vtupass/electricity/electricity.dart';
class ElectricityValidatedContentSection extends StatelessWidget {
  const ElectricityValidatedContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isValidated = context.select(
      (ElectricityCubit element) => element.state.status.isValidated,
    );
    final validatedDetails = context.select(
      (ElectricityCubit element) => element.state.electricityValidationResult,
    );
    final isPurchased = context.select(
      (ElectricityCubit element) => element.state.status.isPurchased,
    );

    final shouldShow = isValidated && !isPurchased && validatedDetails != null;
    final content = validatedDetails?.content;
    final raw = validatedDetails?.raw ?? const <String, dynamic>{};

    final customerName = _firstNonEmpty([
      content?.customerName,
      raw['Customer_Name']?.toString(),
      raw['customer_name']?.toString(),
    ]);

    final meterNumber = _firstNonEmpty([
      content?.meterNumber,
      raw['MeterNumber']?.toString(),
      raw['Meter_Number']?.toString(),
    ]);

    final address = _firstNonEmpty([
      content?.address,
      raw['Address']?.toString(),
      raw['address']?.toString(),
    ]);

    return AnimatedSwitcher(
      duration: 300.ms,
      child: !shouldShow
          ? const SizedBox.shrink()
          : ValidationSummaryContainer(
              child: Column(
                spacing: AppSpacing.xs,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValidationDetailRow(title: 'Customer', value: customerName),
                  const AppDivider(),
                  ValidationDetailRow(
                    title: 'Meter Number',
                    value: meterNumber,
                    color: AppColors.green,
                  ),
                  const AppDivider(),
                  ValidationDetailRow(
                    title: 'Address',
                    value: address,
                  ),
                ],
              ),
            ),
    );
  }
}

String _firstNonEmpty(
  List<String?> values, {
  String fallback = 'Not available',
}) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) return trimmed;
  }
  return fallback;
}
