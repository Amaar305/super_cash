import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DataGiveawayClaimSheet extends StatelessWidget {
  const DataGiveawayClaimSheet({super.key, required this.dataGiveawayItem});
  final DataGiveawayItem dataGiveawayItem;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  context.pop(null);
                },
              ),
            ),
            Gap.v(AppSpacing.lg),
            Assets.images.circleCheck.image(width: 77, height: 77),
            Gap.v(AppSpacing.md),
            // Description
            _Description(dataGiveawayItem: dataGiveawayItem),
            Gap.v(AppSpacing.lg),
            // Form fields
            DataGiveawayClaimForm(network: dataGiveawayItem.network),
            Gap.v(AppSpacing.lg),
            DataGiveawayClaimButton(dataId: dataGiveawayItem.id),
            Gap.v(AppSpacing.xlg),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.dataGiveawayItem});
  final DataGiveawayItem dataGiveawayItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(dataGiveawayItem.dataName, style: context.titleMedium),
        Text(
          'You have successfully claimed ${dataGiveawayItem.dataName} ${dataGiveawayItem.network.capitalize}.\nPlease provide your phone number to receive the data.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, fontWeight: AppFontWeight.extraLight),
        ),
      ],
    );
  }
}
