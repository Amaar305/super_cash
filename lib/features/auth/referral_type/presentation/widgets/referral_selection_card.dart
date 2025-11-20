import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralSelectionContainer extends StatelessWidget {
  const ReferralSelectionContainer({
    super.key,
    this.child,
    this.isSelected = false,
  });

  final Widget? child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 300.ms,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSpacing.lg),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? AppColors.blue
              : Color.fromARGB(255, 197, 203, 205),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: child,
    );
  }
}

class ReferralSelectionCard extends StatelessWidget {
  const ReferralSelectionCard({
    super.key,
    this.isSelected = false,
    required this.numberToRefer,
    required this.rewardToEarn,
    required this.referralTitle,
    required this.referralDescription,
    this.isRecommended = false,
    this.onTap,
  });
  final bool isSelected;
  final bool isRecommended;
  final String numberToRefer;
  final String rewardToEarn;
  final String referralTitle;
  final String referralDescription;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onTap,
      child: ReferralSelectionContainer(
        isSelected: isSelected,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              // spacing: AppSpacing.md,
              children: [
                ReferralSelectionCardFirstChild(
                  title: referralTitle,
                  description: referralDescription,
                  isSelected: isSelected,
                ),

                ReferralSelectionCardSecondChild(
                  numberToRefer: numberToRefer,
                  rewardToEarn: rewardToEarn,
                ),
              ],
            ),

            Positioned(
              top: -10,
              right: 0,

              child: isRecommended
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                      ),
                      child: Text(
                        'Recommended',
                        style: poppinsTextStyle(
                          fontSize: AppSpacing.sm,
                          fontWeight: AppFontWeight.medium,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class ReferralSelectionCardSecondChild extends StatelessWidget {
  const ReferralSelectionCardSecondChild({
    super.key,
    required this.numberToRefer,
    required this.rewardToEarn,
  });
  final String numberToRefer;
  final String rewardToEarn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        color: AppColors.deepBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.md,
        ).copyWith(top: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildColumn(title: 'Number to  Refer', value: numberToRefer),
            Container(width: 1, height: 55, color: AppColors.white),
            _buildColumn(
              title: 'Reward per referral',
              value: rewardToEarn,
              isSecond: true,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildColumn({
    required String title,
    required String value,
    bool isSecond = false,
  }) {
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: !isSecond
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: poppinsTextStyle(
            // fontSize: AppSpacing.,
            color: AppColors.white,
            fontWeight: AppFontWeight.medium,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: poppinsTextStyle(
            fontSize: AppSpacing.lg,
            fontWeight: AppFontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class ReferralSelectionCardFirstChild extends StatelessWidget {
  const ReferralSelectionCardFirstChild({
    super.key,
    required this.title,
    required this.description,
    this.isSelected = false,
  });
  final String title;
  final String description;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Color.fromRGBO(33, 140, 192, .08),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: 300.ms,
              child: isSelected
                  ? Assets.icons.referralUsersIcon.svg(width: 32, height: 32)
                  : Assets.icons.referralUsersIcon2.svg(width: 32, height: 32),
            ),

            Text(
              title,
              style: poppinsTextStyle(
                fontSize: AppSpacing.lg,
                fontWeight: AppFontWeight.bold,
              ),
            ),

            Text(description, style: poppinsTextStyle(fontSize: AppSpacing.md)),
          ],
        ),
      ),
    );
  }
}
