import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/bonus/presentation/cubit/bonus_cubit.dart';

class EarningBonusOverview extends StatelessWidget {
  const EarningBonusOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final isTransafer = context.select(
      (BonusCubit element) => !element.state.isBonusWithdrawn,
    );
    if (!isTransafer) return SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Charges of N25 applies.", style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
