import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../presentation.dart';

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((AppBloc bloc) => bloc.state.user).wallet;
    final showBalance = context.select(
      (HomeCubit bloc) => bloc.state.showBalance,
    );

    return AnimatedCrossFade(
      duration: 200.ms,
      crossFadeState: showBalance
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstCurve: Curves.easeIn,
      secondCurve: Curves.easeOut,
      firstChild: Text(
        wallet.walletBalance,
        style: poppinsTextStyle(
          fontSize: 26,
          fontWeight: AppFontWeight.semiBold,
          color: AppColors.white,
        ),
      ),
      secondChild: _hiddenBalance(),
    );
  }

  Text _hiddenBalance() {
    return Text(
      '****',
      style: TextStyle(
        fontSize: 26,
        fontWeight: AppFontWeight.semiBold,
        color: AppColors.white,
      ),
    );
  }
}
