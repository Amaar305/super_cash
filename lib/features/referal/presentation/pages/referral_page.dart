import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';

import 'package:super_cash/features/referal/referal.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferalCubit(
        claimMyRewardsUseCase: serviceLocator(),
        fetchMyRerralsUseCase: serviceLocator(),
      )..claimMyReward(),
      child: ReferralView(),
    );
  }
}

class ReferralView extends StatelessWidget {
  const ReferralView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.referFriend),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<ReferalCubit>().claimMyReward();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.lg,
            children: [
              ReferralHeader(),
              MyReferralEarningsBonusSection(),
              ReferralShareCodeSection(),
              ReferralStatsSection(),
              ReferralListType(),
              ReferralList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReferralList extends StatelessWidget {
  const ReferralList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = context.select(
      (ReferalCubit element) =>
          element.state.referralResult?.invitees ?? const [],
    );

    return StatusTableCard(users: results);
  }
}
