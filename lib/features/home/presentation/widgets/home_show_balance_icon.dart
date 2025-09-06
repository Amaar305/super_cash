import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeShowBalanceIcon extends StatelessWidget {
  const HomeShowBalanceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final showBalance = context.select(
      (HomeCubit bloc) => bloc.state.showBalance,
    );
    return Tappable.faded(
      onTap: context.read<HomeCubit>().showBalance,
      child: Icon(
        showBalance ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppColors.white,
      ),
    );
  }
}
