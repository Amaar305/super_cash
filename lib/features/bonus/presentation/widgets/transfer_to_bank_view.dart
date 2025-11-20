import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'package:super_cash/features/bonus/presentation/presentation.dart';

class TransferToBankView extends StatelessWidget {
  const TransferToBankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [
        TransferToBankForm(),
        TransferToBankButton(),
        UserBonusOverview(),
      ],
    );
  }
}
