import 'package:app_ui/app_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class DataViewSwitcher extends StatefulWidget {
  const DataViewSwitcher({super.key});

  @override
  State<DataViewSwitcher> createState() => _DataViewSwitcherState();
}

class _DataViewSwitcherState extends State<DataViewSwitcher> {
  @override
  void dispose() {
    hideLoadingOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final instantData = context.select(
      (DataCubit cubit) => cubit.state.instantData,
    );
    return BlocListener<DataCubit, DataState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          showLoadingOverlay(context);
        } else {
          hideLoadingOverlay();
        }
        if (state.status.isError) {
          final selectedPlan = state.selectedPlan;

          final summary = selectedPlan == null
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
                      _SummaryRow(
                        label: 'Network',
                        value: state.selectedNetwork ?? 'Not set',
                      ),
                      _SummaryRow(label: 'Plan', value: selectedPlan.planName),
                      _SummaryRow(
                        label: 'Amount',
                        value: 'N${selectedPlan.planAmount}',
                      ),
                      _SummaryRow(label: 'Recipient', value: state.phone.value),
                    ],
                  ),
                );

          context.showFailureBottomSheet<void>(
            message: state.message.isEmpty ? null : state.message,
            details: summary,
            onPrimary: () {
              if (!context.mounted) return;
              final cubit = context.read<DataCubit>();
              if (selectedPlan != null) {
                cubit.onBuyData();
              } else if (state.selectedNetwork != null) {
                cubit.onFetchPlans(network: state.selectedNetwork!);
              }
            },
            onSecondary: () {
              if (context.mounted) {
                context.pop();
              }
            },
          );
        }
      },
      child: AnimatedCrossFade(
        firstChild: DataInstant(),
        secondChild: DataScheduled(),
        crossFadeState: instantData
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: 100.ms,
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.emphasizeGrey, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: AppFontWeight.semiBold, fontSize: 12),
        ),
      ],
    );
  }
}
