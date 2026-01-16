import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/confirm_transaction_pin/domain/entities/purchase_detail.dart';
import 'package:super_cash/features/confirm_transaction_pin/domain/entities/purchase_type.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/app.dart';
import '../../../../../core/app_strings/app_string.dart';

class DataButton extends StatelessWidget {
  const DataButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (DataCubit cubit) => cubit.state.status.isLoading,
    );

    final selectedNetwork = context.select(
      (DataCubit cubit) => cubit.state.selectedNetwork,
    );

    final selectedPlanIndex = context.select(
      (DataCubit cubit) => cubit.state.selectedIndex,
    );
    final phoneState = context.select((DataCubit cubit) => cubit.state.phone);
    final phone = phoneState.value;

    return PrimaryButton(
      label: AppStrings.proceed,
      isLoading: isLoading,
      onPressed:
          selectedPlanIndex == null ||
              selectedNetwork == null ||
              !phoneState.valid
          ? null
          : () async {
              final plan = context
                  .read<DataCubit>()
                  .state
                  .filteredPlans[selectedPlanIndex];

              final result = await context.push<bool?>(
                AppRoutes.confirmationDialog,
                extra: PurchaseDetail(
                  amount: plan.planAmount.toDouble().toString(),
                  title: 'Purchase Data',
                  description:
                      'You are purchasing ${plan.planName} data to $phone',
                  purchaseType: PurchaseType.data,
                ),
              );

              if (result != null && result && context.mounted) {
                context.read<DataCubit>().onBuyData((res) {
                  context.showConfirmationBottomSheet(
                    title: 'Data Purchase Successful!',
                    okText: 'Done',
                    description: res.description,
                    cancelText: 'Cancel',
                    // onSaved: () {},
                  );
                });
              }
            },
    );
  }
}
