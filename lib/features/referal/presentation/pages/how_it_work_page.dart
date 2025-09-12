import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/referal/referal.dart';

class HowItWorkPage extends StatelessWidget {
  const HowItWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HowItWorkView();
  }
}

class HowItWorkView extends StatelessWidget {
  const HowItWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('How it works'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),

        child: Column(
          spacing: AppSpacing.lg,
          children: [
            ReferralHeader(),
            HowItWorksWidget(),
            HowItWorksListTile(
              title: 'Invite your friends',
              subtitle:
                  'Share your unique referral link with your friends and family. You can find your referral link in the app.',
              leading: Assets.images.chain1.image(),
            ),
            HowItWorksListTile(
              title: 'Sign up and make a transaction',
              subtitle:
                  'When your friends sign up using your referral link and complete their first transaction, both you and your friend will receive a reward.',
              leading: Assets.images.filmReel1.image(),
            ),
            HowItWorksListTile(
              title: 'Earn rewards',
              subtitle:
                  'For every successful referral, you will earn a reward. The more friends you refer, the more rewards you can earn!',
              leading: Assets.images.medal1.image(),
            ),
          ],
        ),
      ),
    );
  }
}

class HowItWorksWidget extends StatelessWidget {
  const HowItWorksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.md,
      children: [
        newMethod(),
        Text('How it works!', style: poppinsTextStyle()),
        newMethod(),
      ],
    );
  }

  Expanded newMethod() {
    return Expanded(
      child: Container(
        width: 128,
        height: 1,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
