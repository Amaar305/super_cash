import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:super_cash/features/home/home.dart';

class HomeScrollText extends StatelessWidget {
  const HomeScrollText({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.select(
      (HomeCubit bloc) => bloc.state.homeSettings?.notification?.message,
    );
    if (text == null || text.isEmpty) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.sm),
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Marquee(
        velocity: 70,
        blankSpace: 10,
        text: text,
        style: TextStyle(fontSize: 12.99, fontWeight: AppFontWeight.regular),
      ),
    );
  }
}
