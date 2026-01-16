import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:super_cash/features/vtupass/airtime/airtime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AirtimeButton extends StatelessWidget {
  const AirtimeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AirtimeCubit>();
    final state = context.select((AirtimeCubit element) => element.state);

    final isLoading = state.status.isLoading;
    final isEnabled = state.selectedNetwork != null;

    void handleConfirmationResult(bool? result) {
      if (result == true && context.mounted) {
        cubit.onSubmit((t) {
          context.showBeneficiaryConfirmationBottomSheet(
            title: 'Airtime Purchase Successful!',
            okText: AppStrings.done,
            description: t.description,
            cancelText: 'Cancel',
            onSaved: () {},
          );
        });
      }
    }

    Future<void> handlePress() async {
      cubit.onValidate(() async {
        final result = await context.push<bool?>(
          AppRoutes.confirmationDialog,
          extra: PurchaseDetail(
            amount: state.amount.value,
            title: 'Purchase Airtime',
            description:
                'You are about to purchase airtime to ${state.phone.value} ${state.selectedNetwork}',
            purchaseType: PurchaseType.airtime,
          ),
        );
        handleConfirmationResult(result);
      });
    }

    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.proceed,
      onPressed: isEnabled ? handlePress : null,
    );
  }
}
