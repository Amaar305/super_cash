import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

class GiveawayHistoryTile extends StatelessWidget {
  const GiveawayHistoryTile({
    super.key,
    required this.giveawayHistory,
    this.onTap,
  });
  final GiveawayHistory giveawayHistory;
  final void Function(AirtimeGiveawayPin giveawayPin)? onTap;

  @override
  Widget build(BuildContext context) {
    final pin = giveawayHistory.giveawayPin;
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: () => onTap?.call(pin),

      leading: getNetworkImage(pin.network, width: 40, height: 40),
      title: Text(
        giveawayHistory.description,
        style: poppinsTextStyle(
          fontWeight: AppFontWeight.semiBold,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        formatDateTime(giveawayHistory.createdAt),
        style: poppinsTextStyle(fontSize: 10),
      ),

      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Text(
            '₦${pin.amount}',
            style: poppinsTextStyle(
              fontSize: 12,
              fontWeight: AppFontWeight.bold,
              color: AppColors.black,
            ),
          ),

          Text(
            'Claimed',
            style: poppinsTextStyle(
              fontSize: 12,
              fontWeight: AppFontWeight.semiBold,
              color: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}
