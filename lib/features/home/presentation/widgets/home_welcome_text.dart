import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWelcomeText extends StatelessWidget {
  const HomeWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(
          'Welcome,',
          style: TextStyle(
            color: AppColors.background,
            fontSize: 18,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        HomeWelcomeUserText(),
      ],
    );
  }
}

class HomeWelcomeUserText extends StatelessWidget {
  const HomeWelcomeUserText({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user;
    return Text(
      user.fullName,
      style: TextStyle(
        color: AppColors.background,
        fontSize: AppSpacing.md,
        fontWeight: AppFontWeight.semiBold,
      ),
    );
  }
}
