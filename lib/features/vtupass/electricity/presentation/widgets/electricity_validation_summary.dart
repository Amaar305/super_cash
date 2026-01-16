import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/confirm_transaction_pin/domain/entities/purchase_detail.dart';
import 'package:super_cash/features/confirm_transaction_pin/domain/entities/purchase_type.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

class ElectricityValidationSummary extends StatelessWidget {
  const ElectricityValidationSummary({
    super.key,
    required this.payload,
    required this.parentContext,
  });

  final ElectricityValidationResult payload;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final details = _extractDetails(payload);

    final customerName = _valueForKeys(details, const [
      'Customer_Name',
      'customer_name',
      'Name',
    ]);
    final meterNumber = _valueForKeys(details, const [
      'Meter_Number',
      'meter_number',
      'Customer_Number',
    ]);
    final address = _valueForKeys(details, const ['Address', 'address']);
    final tariff = _valueForKeys(details, const ['Tariff_Class', 'tariff']);
    final amount = _valueForKeys(details, const ['Amount', 'amount']);
    final token = _valueForKeys(details, const [
      'Token',
      'token',
      'Token_Number',
      'token_number',
    ]);

    final isLoading = context.select(
      (ElectricityCubit cubit) => cubit.state.status.isLoading,
    );

    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (customerName.isNotEmpty)
          _DetailRow(title: 'Customer', value: customerName),
        if (meterNumber.isNotEmpty)
          _DetailRow(title: 'Meter Number', value: meterNumber),
        if (address.isNotEmpty) _DetailRow(title: 'Address', value: address),
        if (tariff.isNotEmpty) _DetailRow(title: 'Tariff', value: tariff),
        if (amount.isNotEmpty) _DetailRow(title: 'Amount', value: amount),
        if (token.isNotEmpty) _TokenTile(token: token),
        PrimaryButton(
          isLoading: isLoading,
          label: AppStrings.buy,
          onPressed: () async {
            final result = await context.push<bool?>(
              AppRoutes.confirmationDialog,
              extra: PurchaseDetail(
                amount: amount,
                title: 'Electricity Subscription',
                description:
                    'You are purchasing electricity for $customerName with meter number $meterNumber',
                purchaseType: PurchaseType.electricity,
              ),
            );

            if (result == true && context.mounted) {
              context.read<ElectricityCubit>().onElectrityPurchase(
                onPurchased: (transaction) {
                  if (!context.mounted) return;
                  context.pop();
                  parentContext.showConfirmationBottomSheet(
                    title: 'Your power purchase was successful.',
                    okText: 'Done',
                    description: transaction.description,
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textStyle = MonaSansTextStyle.label(
      fontWeight: AppFontWeight.black,
      fontSize: AppSpacing.md + 2,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(title, style: textStyle)),
        const Gap.h(AppSpacing.sm),
        Flexible(
          child: Text(value, style: textStyle, textAlign: TextAlign.right),
        ),
      ],
    );
  }
}

class _TokenTile extends StatelessWidget {
  const _TokenTile({required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Token Number',
          style: TextStyle(
            fontSize: AppSpacing.lg + 1,
            fontWeight: AppFontWeight.bold,
            color: AppColors.deepBlue,
          ),
        ),
        Row(
          spacing: AppSpacing.sm,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                token,
                style: TextStyle(
                  fontWeight: AppFontWeight.medium,
                  fontSize: AppSpacing.lg,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Tappable.scaled(
              onTap: () => Clipboard.setData(ClipboardData(text: token)),
              child: Icon(Icons.copy_outlined, size: AppSpacing.lg),
            ),
          ],
        ),
      ],
    );
  }
}

Map<String, String> _extractDetails(ElectricityValidationResult payload) {
  final result = <String, String>{};

  void addIfPresent(String key, String? value) {
    if (value == null) return;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    result[key] = trimmed;
  }

  final content = payload.content;

  addIfPresent('Customer_Name', content?.customerName);
  addIfPresent('MeterNumber', content?.meterNumber);
  addIfPresent('Address', content?.address);
  addIfPresent('Service_Band', content?.serviceBand);
  addIfPresent(
    'Min_Purchase_Amount',
    content?.minPurchaseAmount?.toStringAsFixed(2),
  );
  addIfPresent('Can_Vend', content?.canVend);
  addIfPresent('Customer_Account_Type', content?.customerAccountType);
  addIfPresent('Meter_Type', content?.meterType);
  addIfPresent('Customer_Arrears', content?.customerArrears);

  void collect(Map<dynamic, dynamic> source) {
    source.forEach((key, value) {
      if (value == null) return;
      if (value is Map) {
        collect(Map<dynamic, dynamic>.from(value));
      } else {
        final text = value.toString().trim();
        if (text.isNotEmpty) result[key.toString()] = text;
      }
    });
  }

  collect(payload.raw);

  return result;
}

String _valueForKeys(Map<String, String> details, List<String> keys) {
  for (final key in keys) {
    final direct = details[key];
    if (direct != null && direct.trim().isNotEmpty) return direct.trim();

    final lower = details[key.toLowerCase()];
    if (lower != null && lower.trim().isNotEmpty) return lower.trim();

    final upper = details[key.toUpperCase()];
    if (upper != null && upper.trim().isNotEmpty) return upper.trim();
  }

  return '';
}
