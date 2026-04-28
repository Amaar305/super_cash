import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayHistoryMetricsSection extends StatelessWidget {
  const GiveawayHistoryMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final totalRewards = context.select(
      (GiveawayHistoryCubit cubit) => cubit.state.totalRewards,
    );
    final airtimeAmount = context.select(
      (GiveawayHistoryCubit cubit) => cubit.state.totalAirtimeAmount,
    );
    final dataAmount = context.select((GiveawayHistoryCubit cubit) {
      return cubit.state.data.fold<double>(0, (total, history) {
        if (!history.giveawayType.code.contains('data')) {
          return total;
        }
        return total + (double.tryParse(history.amount) ?? 0);
      });
    });

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.xlg),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 210,
            padding: const EdgeInsets.all(AppSpacing.xlg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.deepBlue,
                  AppColors.blue,
                  const Color(0xff5B8DEF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
          Positioned(
            top: -36,
            right: -28,
            child: _GlowCircle(size: 118, opacity: 0.16),
          ),
          Positioned(
            bottom: -46,
            left: -30,
            child: _GlowCircle(size: 132, opacity: 0.10),
          ),
          Positioned(
            right: 24,
            bottom: 72,
            child: _GlowCircle(size: 18, opacity: 0.25),
          ),
          SizedBox(
            height: 210,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xlg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RewardsHeader(totalRewards: totalRewards),
                  const Spacer(),
                  Row(
                    spacing: AppSpacing.md,
                    children: [
                      Expanded(
                        child: _MetricTile(
                          label: 'Airtime',
                          value: 'N${airtimeAmount.toStringAsFixed(0)}',
                          icon: Icons.phone_iphone_rounded,
                          color: const Color(0xffB7F7D5),
                        ),
                      ),
                      Expanded(
                        child: _MetricTile(
                          label: 'Data',
                          value: '${dataAmount.toStringAsFixed(0)}GB',
                          icon: Icons.signal_cellular_alt_rounded,
                          color: const Color(0xffFFD6A5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardsHeader extends StatelessWidget {
  const _RewardsHeader({required this.totalRewards});

  final int totalRewards;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.sm,
            children: [
              Text(
                'Claimed rewards'.toUpperCase(),
                style: poppinsTextStyle(
                  fontSize: 11,
                  fontWeight: AppFontWeight.medium,
                  color: AppColors.white.withValues(alpha: 0.72),
                ).copyWith(letterSpacing: 1.1),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: AppSpacing.sm,
                children: [
                  Text(
                    '$totalRewards',
                    style: poppinsTextStyle(
                      fontSize: 34,
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.white,
                    ).copyWith(height: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      totalRewards == 1 ? 'win' : 'wins',
                      style: poppinsTextStyle(
                        fontSize: 13,
                        fontWeight: AppFontWeight.medium,
                        color: AppColors.white.withValues(alpha: 0.78),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _AwardBadge(),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 19, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsTextStyle(
                    fontSize: 17,
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.white,
                  ).copyWith(height: 1.1),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsTextStyle(
                    fontSize: 11,
                    fontWeight: AppFontWeight.medium,
                    color: AppColors.white.withValues(alpha: 0.72),
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

class _AwardBadge extends StatelessWidget {
  const _AwardBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.20)),
      ),
      child: Center(
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(child: Assets.icons.giveawayHistoryAward.svg()),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white.withValues(alpha: opacity)),
        color: AppColors.white.withValues(alpha: opacity / 2),
      ),
    );
  }
}
