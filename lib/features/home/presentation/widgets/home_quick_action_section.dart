import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class HomeQuickActionSection extends StatelessWidget {
  const HomeQuickActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(right: 16, left: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeQuickActionButton(
              AppStrings.fundWallet,
              icon: Assets.icons.addOutline.svg(),
              onTap: () => context.push(AppRoutes.addFunds),
            ),
            _vertticalLine(),
            HomeQuickActionButton(
              AppStrings.transfer,
              icon: Assets.icons.transferLine.svg(),
              onTap: () => context.push(AppRoutes.transfer),
            ),
            _vertticalLine(),
            HomeQuickActionButton(
              AppStrings.virtualCard,
              icon: Assets.icons.creditCards.svg(),
              onTap: () => context.push(AppRoutes.virtualCard),
            ),
          ],
        ),
      ),
    );
  }

  Container _vertticalLine() {
    return Container(height: 30, width: 0.3, color: AppColors.background);
  }
}

class HomeQuickActionButton extends StatelessWidget {
  const HomeQuickActionButton(
    this.text, {
    super.key,
    this.onTap,
    required this.icon,
  });
  final String text;
  final VoidCallback? onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      throttle: true,
      throttleDuration: 200.ms,
      onTap: onTap,
      child: Column(
        spacing: AppSpacing.xs,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(dimension: 24, child: icon),
          Text(
            text,
            style: poppinsTextStyle(
              fontSize: 12,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
