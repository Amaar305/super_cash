import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DirectAirtimeGiveawaySheet extends StatelessWidget {
  const DirectAirtimeGiveawaySheet({super.key, required this.giveaway});
  final DirectAirtimeModel giveaway;

  void _confirmClose(BuildContext context) => context.confirmAction(
    fn: () => context.pop(null),
    title: AppStrings.goBackTitle,
    content: AppStrings.goBackDescrption,
    noText: AppStrings.cancel,
    yesText: AppStrings.goBack,
    yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () => _confirmClose(context),
              ),
            ),
            Gap.v(AppSpacing.lg),
            Assets.images.circleCheck.image(width: 77, height: 77),
            Gap.v(AppSpacing.md),
            // Description
            _Description(giveaway: giveaway),
            Gap.v(AppSpacing.lg),
            // Form fields
            DirectAirtimeGiveawayClaimForm(network: giveaway.network),
            Gap.v(AppSpacing.lg),
            DirectAirtimeGiveawayClaimButton(airtimeId: giveaway.id),
            Gap.v(AppSpacing.xlg),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.giveaway});
  final DirectAirtimeModel giveaway;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(giveaway.airtimeName, style: context.titleMedium),
        Text(
          'You have successfully claimed ${giveaway.airtimeName} ${giveaway.network.capitalize}.\nPlease provide your phone number to receive the airtime.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, fontWeight: AppFontWeight.extraLight),
        ),
      ],
    );
  }
}
