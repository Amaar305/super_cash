import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/referal/referal.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyReferralEarningsBonusSection extends StatelessWidget {
  const MyReferralEarningsBonusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.lg,
        children: [
          const _ReferralTypeRow(),
          const _RewardAndWithdrawRow(),
          ReferralInvitationPercentage(),
        ],
      ),
    );
  }
}

class ReferralInvitationPercentage extends StatelessWidget {
  const ReferralInvitationPercentage({super.key});

  @override
  Widget build(BuildContext context) {
    final referralResult = context.select(
      (ReferalCubit bloc) => bloc.state.referralResult,
    );
    final totals = referralResult?.referraalTotal;
    final completedInvites = totals?.invited ?? 0;
    final hasTarget = referralResult?.campaign.hasLimitedReferees ?? false;
    final targetInvites = referralResult?.campaign.maxReferees ?? 0;
    final totalForProgress = hasTarget
        ? targetInvites
        : (completedInvites == 0 ? 1 : completedInvites);
    final percent = totalForProgress == 0
        ? 0.0
        : (completedInvites / totalForProgress).clamp(0.0, 1.0);
    final progressLabel = hasTarget
        ? '$completedInvites of $targetInvites complete'
        : '$completedInvites invited';
    if (targetInvites <= 0) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: AppSpacing.sm,
      children: [
        Text(progressLabel, style: poppinsTextStyle(fontSize: 12)),
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            child: LinearPercentIndicator(
              width: context.screenWidth * 0.9,
              lineHeight: 6,
              percent: percent,
              barRadius: Radius.circular(50),
              backgroundColor: Color(0xffE7EAEE),
              progressColor: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReferralTypeRow extends StatelessWidget {
  const _ReferralTypeRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconContainer(
          child: Icon(Icons.wallet_outlined, color: AppColors.deepBlue),
        ),
        Gap.h(AppSpacing.lg),
        Text(
          'Referral Type:',
          style: poppinsTextStyle(
            fontWeight: AppFontWeight.bold,
            fontSize: AppSpacing.md,
          ),
        ),
        Gap.h(AppSpacing.sm),
        const _ReferralTypeBadge(),
      ],
    );
  }
}

class _ReferralTypeBadge extends StatelessWidget {
  const _ReferralTypeBadge();

  @override
  Widget build(BuildContext context) {
    final r = context.select(
      (ReferalCubit element) => element.state.referralResult?.campaign.name,
    );
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        color: const Color(0xffF7F8F9),
      ),
      alignment: const Alignment(0, 0),
      child: Text(
        '$r',
        style: poppinsTextStyle(
          fontWeight: AppFontWeight.bold,
          fontSize: 13,
          color: AppColors.deepBlue,
        ),
      ),
    );
  }
}

class _RewardAndWithdrawRow extends StatelessWidget {
  const _RewardAndWithdrawRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_RewardClaimedColumn(), ReferralWithdrawEraningsButton()],
    );
  }
}

class _RewardClaimedColumn extends StatelessWidget {
  const _RewardClaimedColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Referral Bonus',
          style: poppinsTextStyle(
            fontSize: AppSpacing.md,
            fontWeight: AppFontWeight.light,
          ),
        ),
        const ReferralEarningBonus(),
      ],
    );
  }
}

class _IconContainer extends StatelessWidget {
  const _IconContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,
      height: 31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        color: const Color(0xffF7F8F9),
      ),
      alignment: const Alignment(0, 0),
      child: FittedBox(child: child),
    );
  }
}
