import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';
import 'package:super_cash/features/vtupass/widgets/widgets.dart';

class AirtimeGiveawayCard extends StatelessWidget {
  const AirtimeGiveawayCard({
    super.key,
    required this.giveawayPin,
    this.onClaimed,
  });
  final AirtimeGiveawayPin giveawayPin;
  final void Function(String planId)? onClaimed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
        border: Border.all(width: 0.5, color: Color.fromRGBO(197, 198, 204, 1)),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.topRight,
        //   colors: [Color(0xFF7DB5D0), Color(0xFF266F92)],
        // ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(2, 1),
            blurRadius: 4,
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.md,
        children: [
          // Network Logo
          // Assets.images.mtn.image(width: 24, height: 24),
          getNetworkImage(giveawayPin.network, width: 24, height: 24),

          // Title
          Text(
            'Airtime Giveaway',
            style: poppinsTextStyle(
              fontSize: 11,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          // Masked Airtime PIN Number
          FittedBox(
            child: Text(
              'PIN: ${giveawayPin.maskedPin}',
              style: poppinsTextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ),

          // Price and Claim Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₦${giveawayPin.amount}',
                style: poppinsTextStyle(
                  fontSize: 16,
                  fontWeight: AppFontWeight.bold,
                ),
              ),

              _ClaimedButton(
                isClaimed: giveawayPin.isUsed,
                onPressed: () => onClaimed?.call(giveawayPin.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClaimedButton extends StatelessWidget {
  const _ClaimedButton({this.isClaimed = false, this.onPressed});
  final bool isClaimed;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final color = isClaimed ? AppColors.grey : AppColors.blue;
    final text = isClaimed ? 'Claimed' : 'Claim';
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: isClaimed ? null : onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
          child: Text(
            text,
            style: poppinsTextStyle(
              fontSize: 12,
              color: AppColors.white,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}
