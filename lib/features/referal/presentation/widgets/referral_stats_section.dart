import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/referal/referal.dart';

class ReferralStatsSection extends StatelessWidget {
  const ReferralStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((ReferalCubit element) => element.state);
    final referralUsers = state.referralUsers;
    final totals = state.referralResult?.referraalTotal;
    final totalReferrals = totals?.invited ?? referralUsers.length;
    final totalRewards = totals?.totalCollectedAmount ??
        referralUsers
            .fold<double>(0, (sum, user) => sum + user.rewardAmount)
            .toStringAsFixed(2);
    final totalActive =
        totals?.active ?? referralUsers.where((user) => user.active).length;
    final totalVerified = totals?.verified ??
        referralUsers.where((user) => user.verified).length;
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.lg,
          children: [
            ReferralStatContainer(
              title: 'Total Referral',
              subtitle: '($totalReferrals)',
            ),
            ReferralStatContainer(
              title: 'Total Rewards',
              subtitle: 'NGN$totalRewards',
            ),
          ].map((item) => Expanded(child: item)).toList(),
        ),
        Row(
          spacing: AppSpacing.lg,
          children: [
            ReferralStatContainer(
              title: 'Active',
              subtitle: '($totalActive)',
              color: AppColors.green,
            ),
            ReferralStatContainer(
              title: 'Verified',
              subtitle: '($totalVerified)',
              color: Color(0xff3B6AED),
            ),
          ].map((item) => Expanded(child: item)).toList(),
        ),
      ],
    );
  }
}
