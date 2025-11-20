import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class WithdrawBonusView extends StatelessWidget {
  const WithdrawBonusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: const [
        BonusAmountField(),
        WithdrawBonusButton(),
        UserBonusOverview(),
      ],
    );
  }
}
