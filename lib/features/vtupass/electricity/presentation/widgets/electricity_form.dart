import 'package:app_ui/app_ui.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/vtupass/electricity/presentation/widgets/electricity_validated_content_section.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

class ElectricityForm extends StatefulWidget {
  const ElectricityForm({super.key});

  @override
  State<ElectricityForm> createState() => _ElectricityFormState();
}

class _ElectricityFormState extends State<ElectricityForm> {
  @override
  void initState() {
    super.initState();
    context.read<ElectricityCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ElectricityCubit>().resetState();
  }

  @override
  void dispose() {
    hideLoadingOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ElectricityCubit, ElectricityState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          showLoadingOverlay(context);
        } else {
          hideLoadingOverlay();
        }
        if (state.status.isError) {
          final plan = state.selectedPlan;
          final summary = plan == null
              ? null
              : PurchaseContainerInfo(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.xs,
                    children: [
                      Text(
                        'Review selection',
                        style: poppinsTextStyle(
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                      SummaryRow(label: 'Provider', value: plan.discoName),
                      SummaryRow(
                        label: 'Type',
                        value: state.prepaid ? 'Prepaid' : 'Postpaid',
                      ),
                      SummaryRow(
                        label: 'Meter',
                        value: state.meter.value.isEmpty
                            ? 'Not set'
                            : state.meter.value,
                      ),
                      SummaryRow(
                        label: 'Amount',
                        value: state.amount.value.isEmpty
                            ? 'Not set'
                            : 'N${state.amount.value}',
                      ),
                      SummaryRow(
                        label: 'Phone',
                        value: state.phone.value.isEmpty
                            ? 'Not set'
                            : state.phone.value,
                      ),
                    ],
                  ),
                );
          context.showFailureBottomSheet<void>(
            message: state.message.isEmpty ? null : state.message,
            details: summary,
            onPrimary: () {
              if (context.mounted) {
                if (state.electricityValidationResult == null) {
                  context.read<ElectricityCubit>().onElectricityValidation();
                } else {
                  context.pop();
                }
              }
            },
            onSecondary: () {
              if (context.mounted) {
                context.pop();
              }
            },
          );
        }

        if (state.status.isPurchased) {
          final response = state.transactionResponse;
          if (response == null) return;
          final plan = state.selectedPlan;
          final tokens = _formatTokens(response.token);
          context.showExtraBottomSheet(
            title: 'Electricity Purchase Successful!',
            description: response.description,
            icon: Assets.images.circleCheck.image(),
            children: [
              Tappable.faded(
                onTap: () {
                  copyText(
                    context,
                    tokens.join(''),
                    'Token copied to clipboard',
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      response.token ?? '',
                      style: poppinsTextStyle(
                        fontSize: 16,
                        fontWeight: AppFontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ),

                    Icon(Icons.copy, color: AppColors.deepBlue, size: 16),
                  ],
                ),
              ),
              PurchaseContainerInfo(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      'Purchase details',
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ),
                    SummaryRow(
                      label: 'Provider',
                      value: plan?.discoName ?? 'Not set',
                    ),
                    SummaryRow(
                      label: 'Type',
                      value: state.prepaid ? 'Prepaid' : 'Postpaid',
                    ),
                    SummaryRow(
                      label: 'Meter',
                      value: state.meter.value.isEmpty
                          ? 'Not set'
                          : state.meter.value,
                    ),
                    SummaryRow(
                      label: 'Phone',
                      value: state.phone.value.isEmpty
                          ? 'Not set'
                          : state.phone.value,
                    ),
                    SummaryRow(
                      label: 'Amount',
                      value: response.formattedAmount,
                    ),

                    // _SummaryRow(label: 'Reference', value: response.reference),
                  ],
                ),
              ),
              PrimaryButton(label: 'Done', onPressed: context.pop),
            ],
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,
        children: [
          ElectricityPlanDropdown(),
          ElectricityMeterNumberField(),
          ElectricityAmountField(),

          // SHow validated response here
          ElectricityValidatedContentSection(),
          ElectricityPhoneField(),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.copy = false,
  });

  final String label;
  final String value;
  final bool copy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.emphasizeGrey, fontSize: 12),
        ),
        FittedBox(
          child: Row(
            spacing: AppSpacing.sm,
            children: [
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 12,
                ),
              ),
              if (copy)
                Icon(
                  Icons.copy_outlined,
                  color: AppColors.deepBlue,
                  size: AppSpacing.lg,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class TokenSection extends StatelessWidget {
  const TokenSection({super.key, required this.tokens});

  final List<String> tokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Token',
          style: TextStyle(
            fontSize: AppSpacing.lg,
            fontWeight: AppFontWeight.semiBold,
            color: AppColors.deepBlue,
          ),
        ),
        SelectableText(
          tokens.join(' '),
          style: const TextStyle(
            fontWeight: AppFontWeight.bold,
            color: AppColors.deepBlue,
            letterSpacing: 1.2,
            fontSize: AppSpacing.lg,
          ),
        ),
      ],
    );
  }
}

List<String> _formatTokens(String? rawToken) {
  if (rawToken == null) return const [];
  final cleaned = rawToken.trim();
  if (cleaned.isEmpty) return const [];

  final splitTokens = cleaned
      .split(RegExp('[\\s,;|]+'))
      .where((e) => e.isNotEmpty)
      .toList();
  final entries = splitTokens.isEmpty ? [cleaned] : splitTokens;

  return entries.map(_chunkToken).toList();
}

String _chunkToken(String token) {
  final normalized = token.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
  final buffer = StringBuffer();
  for (var i = 0; i < normalized.length; i++) {
    if (i > 0 && i % 4 == 0) buffer.write(' ');
    buffer.write(normalized[i]);
  }
  return buffer.toString().trim();
}
