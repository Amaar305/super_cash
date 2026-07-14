import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Opens the official rules & regulations for Super Cash giveaways,
/// including the required disclosure that giveaways are not affiliated
/// with, sponsored by, or endorsed by Apple Inc. or the App Store.
void showGiveawayRulesSheet(BuildContext context) {
  context.showBottomModal(
    isScrollControlled: true,
    title: 'Giveaway Rules & Terms',
    content: SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.screenHeight * 0.75),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.md,
            children: [
              _AppleDisclaimerCallout(),
              _RuleSection(
                title: 'No Purchase Necessary',
                body:
                    'No purchase, payment, or in-app transaction is '
                    'required to enter or win any giveaway. Making a '
                    'purchase does not improve your chances of winning.',
              ),
              _RuleSection(
                title: 'Eligibility',
                body:
                    'Giveaways are open to registered Super Cash users who '
                    'meet the criteria stated on each giveaway. Super Cash '
                    'staff and their immediate family are not eligible.',
              ),
              _RuleSection(
                title: 'Entry Period',
                body:
                    'Each giveaway runs for the dates shown on its details '
                    'page. Entries received outside that window are not '
                    'counted.',
              ),
              _RuleSection(
                title: 'Winner Selection',
                body:
                    'Winners are determined using the method described for '
                    'that giveaway (e.g. first-come-first-served, random '
                    'draw, or a qualifying action), at the sole discretion '
                    'of Super Cash.',
              ),
              _RuleSection(
                title: 'Prizes',
                body:
                    'Prize type, value and quantity are listed on each '
                    'giveaway. Prizes are non-transferable and cannot be '
                    'exchanged for cash unless the prize is cash itself.',
              ),
              _RuleSection(
                title: 'Changes & Cancellation',
                body:
                    'Super Cash may modify, suspend, or cancel a giveaway '
                    'at its discretion, including in cases of suspected '
                    'fraud or technical error.',
              ),
              _RuleSection(
                title: 'Questions',
                body:
                    'For questions about a specific giveaway, reach out to '
                    'our support team from the Help section of the app.',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _AppleDisclaimerCallout extends StatelessWidget {
  const _AppleDisclaimerCallout();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightBlueFilled,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Text(
        'This promotion is operated solely by Super Cash. It is not '
        'sponsored, endorsed, administered by, or associated with Apple '
        'Inc., the App Store, or any of their affiliates.',
        style: TextStyle(
          fontSize: 12,
          height: 1.5,
          fontWeight: AppFontWeight.medium,
          color: AppColors.deepBlue,
        ),
      ),
    );
  }
}

class _RuleSection extends StatelessWidget {
  const _RuleSection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xxs,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: AppFontWeight.semiBold,
            color: AppColors.black,
          ),
        ),
        Text(
          body,
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: AppColors.emphasizeGrey,
          ),
        ),
      ],
    );
  }
}
