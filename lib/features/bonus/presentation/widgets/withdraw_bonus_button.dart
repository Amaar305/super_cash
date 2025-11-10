import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';
import 'package:super_cash/features/vtupass/airtime/airtime.dart';

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
              extra: VeryPurchaseInfo(
                amount: 'N${state.amount.value}',
                number: '',
                text1: 'You are withdrawing ',
                text2: 'bonus to your wallet',
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
