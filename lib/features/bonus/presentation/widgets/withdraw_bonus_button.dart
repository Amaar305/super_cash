import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';
import 'package:super_cash/features/confirm_transaction_pin/domain/entities/purchase_detail.dart';
import 'package:super_cash/features/confirm_transaction_pin/domain/entities/purchase_type.dart';

class WithdrawBonusButton extends StatelessWidget {
  const WithdrawBonusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusCubit, BonusState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return PrimaryButton(
          isLoading: state.status.isLoading,
          label: 'Withdraw Bonus',
          onPressed: () async {
            final result = await context.push<bool?>(
              AppRoutes.confirmationDialog,
              extra: PurchaseDetail(
                amount: state.amount.value,
                title: 'Withdraw Bonus',
                description:
                    'You are withdrawing ${state.amount.value} bonus to your wallet',
                purchaseType: PurchaseType.others,
              ),
            );

            if (result != null && result && context.mounted) {
              context.read<BonusCubit>().withdrawBonus();
            }
          },
        );
      },
    );
  }
}
