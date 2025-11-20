import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralSelectionListView extends StatelessWidget {
  const ReferralSelectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final referrals = context.select(
      (ReferralTypeCubit element) =>
          element.state.referralTypeResult?.campaigns ?? [],
    );
    final selectedCampaign = context.select(
      (ReferralTypeCubit element) => element.state.selectedCampaign,
    );
    return ListView.builder(
      itemCount: referrals.length,
      padding: EdgeInsets.only(top: 10),
      itemBuilder: (context, index) {
        final referral = referrals[index];
        return ReferralSelectionCard(
          isSelected: referral.id == selectedCampaign?.id,
          isRecommended: !referral.hasLimitedReferees,
          numberToRefer: referral.maxRefereesString,
          rewardToEarn: referral.perRefereeReward.toString(),
          referralTitle: !referral.hasLimitedReferees
              ? referral.maxRefereesString
              : '${referral.maxReferees} for ${((referral.maxReferees ?? 1) * referral.perRefereeReward)}',
          referralDescription: referral.description,
          onTap: () {
            context.read<ReferralTypeCubit>().onCampaignSelected(referral);
          },
        );
      },
    );
  }
}
