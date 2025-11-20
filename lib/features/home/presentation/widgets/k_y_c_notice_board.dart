import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KYCNoticeBoard extends StatelessWidget {
  const KYCNoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final isKYCVerified = context.select(
      (AppCubit cubit) => cubit.state.user?.isKycVerified ?? false,
    );

    if (isKYCVerified) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.deepBlue, AppColors.green.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.xlg),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.25),
              blurRadius: 28,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -AppSpacing.xlg,
              right: -AppSpacing.lg,
              child: _AccentCircle(
                diameter: 150,
                color: AppColors.white.withValues(alpha: 0.08),
              ),
            ),
            Positioned(
              bottom: -AppSpacing.md,
              left: -AppSpacing.lg,
              child: _AccentCircle(
                diameter: 120,
                color: AppColors.white.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSpacing.xxxlg),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Icon(
                      Icons.verified_user_outlined,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.xs,
                      children: [
                        Text(
                          'Complete your KYC',
                          style: poppinsTextStyle(
                            fontSize: 16,
                            fontWeight: AppFontWeight.semiBold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          'Verify your identity now to unlock seamless transfers, higher limits, and rewards tailored for you.',
                          style: poppinsTextStyle(
                            fontSize: 12,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.md),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Text(
                          'Verify Now',
                          style: poppinsTextStyle(
                            fontSize: 12,
                            fontWeight: AppFontWeight.semiBold,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentCircle extends StatelessWidget {
  const _AccentCircle({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
