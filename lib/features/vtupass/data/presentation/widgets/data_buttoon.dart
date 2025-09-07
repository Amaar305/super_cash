import 'package:app_ui/app_ui.dart';
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
    final phone = context.select((DataCubit cubit) => cubit.state.phone.value);

    return PrimaryButton(
      label: AppStrings.proceed,
      isLoading: isLoading,
      onPressed: selectedPlanIndex == null || selectedNetwork == null
          ? null
          : () async {
              final plan = context
                  .read<DataCubit>()
                  .state
                  .filteredPlans[selectedPlanIndex];

              final result = await context.push<bool?>(
                AppRoutes.confirmationDialog,
                extra: VeryPurchaseInfo(
                  amount: plan.planName,
                  number: phone,
                  text1: 'You are sending ',
                  text2: 'data to ',
                ),
              );

              if (result != null && result && context.mounted) {
                context.read<DataCubit>().onBuyData((res) {
                  context.showBeneficiaryConfirmationBottomSheet(
                    title: 'Airtime Purchase Successful!',
                    okText: 'Done',
                    description: res.description,
                    cancelText: 'Cancel',
                    onSaved: () {},
                  );
                });
              }
            },
    );
  }
}
