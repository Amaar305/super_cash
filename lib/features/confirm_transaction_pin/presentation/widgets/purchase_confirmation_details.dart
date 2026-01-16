import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';


class PurchaseConfirmationDetails extends StatelessWidget {
  const PurchaseConfirmationDetails({
    super.key,
    required this.title,
    required this.description,
    this.purchaseType = PurchaseType.others,
  });

  final String title;
  final String description;
  final PurchaseType purchaseType;

  IconData _iconForPurchaseType(PurchaseType type) {
    switch (type) {
      case PurchaseType.airtime:
        return Icons.phone_iphone;
      case PurchaseType.data:
        return Icons.wifi;
      case PurchaseType.cableTv:
        return Icons.tv;
      case PurchaseType.electricity:
        return Icons.flash_on;
      case PurchaseType.others:
        return Icons.receipt_long;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBlue, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(
              _iconForPurchaseType(purchaseType),
              color: AppColors.white,
              size: 30,
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              spacing: AppSpacing.xs,
              children: [
                Text(
                  title.length > 25 ? '${title.substring(0, 25)}...' : title,
                  style: poppinsTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                  ),
                ),
                Divider(color: AppColors.brightGrey, height: 1),

                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: poppinsTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
