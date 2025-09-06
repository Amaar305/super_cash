import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class ReferalPage extends StatelessWidget {
  const ReferalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferalCubit(
        claimMyRewardsUseCase: serviceLocator(),
        fetchMyRerralsUseCase: serviceLocator(),
      )..fetchMyReferrals(),
      child: ReferalView(),
    );
  }
}

class ReferalView extends StatelessWidget {
  const ReferalView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.referFriend),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: BlocConsumer<ReferalCubit, ReferalState>(
          listenWhen: (previous, current) => previous.status != current.status,
          buildWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure && state.message.isNotEmpty) {
              openSnackbar(
                SnackbarMessage.error(title: state.message),
                clearIfQueue: true,
              );
            }

            if (state.status.isSuccess && state.referralUsers.isNotEmpty) {
              context.showBottomModal(
                title: 'Success',
                content: Column(
                  children: state.referralUsers
                      .map((e) => ListTile(title: Text(e.username)))
                      .toList(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              spacing: AppSpacing.xlg,
              children: [
                ReferalTotalSection(),
                SizedBox.shrink(),
                ReferalLinkSection(),
                SizedBox.shrink(),
                ReferalBenefitsSection(),
              ],
            );
          },
        ),
      ),
    );
  }
}
