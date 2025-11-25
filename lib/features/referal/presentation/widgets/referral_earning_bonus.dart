import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralEarningBonus extends StatelessWidget {
  const ReferralEarningBonus({super.key});

  @override
  Widget build(BuildContext context) {
    final bonus = context.select(
      (AppCubit bloc) => bloc.state.user?.wallet.bonus ?? '0',
    );
    return Text(
      'N$bonus',
      style: poppinsTextStyle(
        fontSize: AppSpacing.xlg - 2,
        fontWeight: AppFontWeight.semiBold,
      ),
    );
  }
}
