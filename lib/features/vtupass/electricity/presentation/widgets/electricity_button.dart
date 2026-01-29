import 'package:app_ui/app_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectricityButton extends StatelessWidget {
  const ElectricityButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ElectricityCubit cubit) => cubit.state.status.isLoading,
    );
    final isValidated = context.select(
      (ElectricityCubit cubit) => cubit.state.status.isValidated,
    );
    final selectedPlan = context.select(
      (ElectricityCubit cubit) => cubit.state.selectedPlan,
    );
    final phoneState = context.select(
      (ElectricityCubit cubit) => cubit.state.phone,
    );
    final isEnabled =
        selectedPlan != null &&
        phoneState.valid &&
        phoneState.value.trim().isNotEmpty;

    return PrimaryButton(
      isLoading: isLoading,
      label: isValidated ? AppStrings.buy : AppStrings.proceed,
      onPressed: !isEnabled
          ? null
          : () async {
              final cubit = context.read<ElectricityCubit>();

              cubit
                ..onAmountFocused()
                ..onDecoderFocused()
                ..onPhoneFocused();

              final state = cubit.state;
              final isFormValid =
                  state.selectedPlan != null &&
                  state.amount.valid &&
                  state.phone.valid &&
                  state.meter.valid;

              if (!isFormValid) return;

              if (isValidated) {
                final amount = cubit.state.amount.value;
                final charges =
                    cubit.state.electricityValidationResult?.charges ?? 0.0;
                final parsedAmount = double.tryParse(amount.trim()) ?? 0.0;
                final totalValue = parsedAmount + charges;
                final total = totalValue == totalValue.roundToDouble()
                    ? totalValue.toStringAsFixed(0)
                    : totalValue.toString();


                final result = await context.push<bool?>(
                  AppRoutes.confirmationDialog,
                  extra: PurchaseDetail(
                    amount: total,
                    title: 'Purchase Electricity',
                    description:
                        'You are purchasing ${cubit.state.selectedPlan?.discoName}  electricity to ${cubit.state.meter.value}',
                    purchaseType: PurchaseType.electricity,
                  ),
                );

                if (result == true && context.mounted) {
                  context.read<ElectricityCubit>().onElectrityPurchase();
                }
              } else {
                await cubit.onElectricityValidation();
              }
            },
    );
  }
}

void showVerificationSheet(
  ElectricityValidationResult payload,
  BuildContext rootContext,
) {
  if (!rootContext.mounted) return;
  rootContext.showExtraBottomSheet(
    title: 'Electricity Validation Successful!',
    description: payload.message,
    icon: Assets.images.circleCheck.image(),
    children: [
      BlocProvider.value(
        value: rootContext.read<ElectricityCubit>(),
        child: ElectricityValidationSummary(
          payload: payload,
          parentContext: rootContext,
        ),
      ),
    ],
  );
}
