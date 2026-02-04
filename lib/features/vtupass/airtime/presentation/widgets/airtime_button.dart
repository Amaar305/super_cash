import 'package:app_ui/app_ui.dart';
import 'package:env/env.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

import 'package:url_launcher/url_launcher.dart';

class AirtimeButton extends StatelessWidget {
  const AirtimeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AirtimeCubit>();
    final state = context.select((AirtimeCubit element) => element.state);
    final phone = state.phone;
    final network = state.selectedNetwork;

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
            onDone: () => context
              ..pop() //Remove the bottom sheet
              ..pop(), //Navigate to Home

            onRate: () {
              context.pop();
              launchLink(
                EnvProd.playStoreUrl,
                browserMode: LaunchMode.externalApplication,
              );
            },
            onSaved: () {
              context.pop();
              context.goNamedSafe(
                RNames.saveBeneficiary,
                extra: Beneficiary(
                  id: '',
                  name: '',
                  phone: phone.value,
                  network: network ?? '',
                ),
              );
            },
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
