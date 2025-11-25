import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/routes/routes.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class Bonus extends StatelessWidget {
  const Bonus({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((AppCubit bloc) => bloc.state.user)?.wallet;
    final showBalance = context.select(
      (HomeCubit bloc) => bloc.state.showBalance,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Bonus Balance:',
          style: poppinsTextStyle(
            fontSize: 12,
            fontWeight: AppFontWeight.semiBold,
            color: AppColors.white,
          ),
        ),
        Tappable(
          onTap: () => context.goNamedSafe(RNames.bonus),
          child: Container(
            width: 60,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFEBF8FF),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                !showBalance ? '***' : 'N${wallet?.bonus ?? 0}',
                style: poppinsTextStyle(
                  fontSize: 12,
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.primary2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
