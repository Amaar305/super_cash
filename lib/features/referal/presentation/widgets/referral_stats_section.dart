import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/referal/referal.dart';

class ReferralStatsSection extends StatelessWidget {
  const ReferralStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((ReferalCubit element) => element.state);
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.lg,
          children: [
            ReferralStatContainer(
              title: 'Total Referral',
              subtitle: '(${state.totalCount})',
            ),
            ReferralStatContainer(
              title: 'Total Rewards',
              subtitle: 'NGN${state.totalAmount}',
            ),
          ].map((item) => Expanded(child: item)).toList(),
        ),
        Row(
          spacing: AppSpacing.lg,
          children: [
            ReferralStatContainer(
              title: 'Active',
              subtitle: '(${state.totalActive})',
              color: AppColors.green,
            ),
            ReferralStatContainer(
              title: 'Verified',
              subtitle: '(${state.totalVerified})',
              color: Color(0xff3B6AED),
            ),
          ].map((item) => Expanded(child: item)).toList(),
        ),
      ],
    );
  }
}
