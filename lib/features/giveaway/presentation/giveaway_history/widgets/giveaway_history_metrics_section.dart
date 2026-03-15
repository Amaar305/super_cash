import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayHistoryMetricsSection extends StatelessWidget {
  const GiveawayHistoryMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final totalRewads = context.select(
      (GiveawayHistoryCubit cubit) => cubit.state.totalRewards,
    );
    final airtimeAmount = context.select(
      (GiveawayHistoryCubit cubit) => cubit.state.totalAirtimeAmount,
    );
    return Container(
      width: double.infinity,
      height: 210,
      padding: EdgeInsets.all(AppSpacing.xlg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.xlg),
        gradient: LinearGradient(
          colors: [
            AppColors.blue.withValues(alpha: 0.5),
            AppColors.blue.withValues(alpha: 0.2),
          ],
        ),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: AppSpacing.md,
        children: [
          // First
          NewWidgetFirst(totalRewards: totalRewads),

          // Second
          NewWidgetSecondChild(airtimeAmount: airtimeAmount, dataAmount: 32),
        ],
      ),
    );
  }
}

class NewWidgetSecondChild extends StatelessWidget {
  const NewWidgetSecondChild({
    super.key,
    required this.airtimeAmount,
    required this.dataAmount,
  });
  final double airtimeAmount;
  final double dataAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: Metrics(
            label: 'Airtime',
            icon: Icons.phone,
            value: '₦${airtimeAmount.toStringAsFixed(0)}',
            metric: '+12.5%',
          ),
        ),
        Container(width: 0.2, height: 53, color: AppColors.background2),
        Expanded(
          child: Metrics(
            label: 'Data',
            icon: Icons.signal_cellular_alt,
            isAirtime: false,
            value: '85GB',
            metric: '+18.2%',
          ),
        ),
      ],
    );
  }
}

class Metrics extends StatelessWidget {
  const Metrics({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.metric,
    this.isAirtime = true,
  });
  final String label;
  final IconData icon;
  final bool isAirtime;
  final String value;
  final String metric;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          Row(
            spacing: AppSpacing.sm,
            children: [
              Icon(
                icon,
                size: 18,
                color: isAirtime ? Color(0xff3B82F6) : Color(0xffF472B6),
              ),
              Text(
                label,
                style: poppinsTextStyle(
                  fontSize: 12,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: poppinsTextStyle(
              fontSize: 18,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          // Text(
          //   metric,
          //   style: poppinsTextStyle(
          //     fontSize: 12,
          //     color: Color(0xff34D399),
          //     fontWeight: AppFontWeight.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class NewWidgetFirst extends StatelessWidget {
  const NewWidgetFirst({super.key, required this.totalRewards});
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
                'Total Rewards'.toUpperCase(),
                style: poppinsTextStyle(
                  fontSize: 12,
                  fontWeight: AppFontWeight.medium,
                  color: AppColors.darkGrey,
                ).copyWith(letterSpacing: 1.2, height: 1.5),
              ),
              Row(
                spacing: AppSpacing.sm,
                children: [
                  Text(
                    '$totalRewards',
                    style: poppinsTextStyle(
                      fontSize: 24,
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  Text(
                    'Wins',
                    style: poppinsTextStyle(
                      fontSize: 13,
                    ).copyWith(letterSpacing: 1.5),
                  ),
                ],
              ),
            ],
          ),
        ),
        _Badge(),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(AppSpacing.xlg),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.30)),
      ),
      child: Center(child: Assets.icons.giveawayHistoryAward.svg()),
    );
  }
}
