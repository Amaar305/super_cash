import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';

class UserBonusOverview extends StatelessWidget {
  const UserBonusOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final bonus = context.select(
      (AppCubit cubit) => cubit.state.user?.wallet.bonus ?? '0',
    );

    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary2,
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                Text(
                  'Available bonus',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: AppFontWeight.medium,
                    color: AppColors.darkGrey,
                  ),
                ),
                Text(
                  '₦$bonus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.primary2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
