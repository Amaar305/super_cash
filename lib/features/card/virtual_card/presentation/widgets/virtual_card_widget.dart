import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart' as s;

import '../../virtual_card.dart';

class VirtualCardWidget extends StatelessWidget {
  const VirtualCardWidget({super.key, required this.card});
  final s.Card card;

  @override
  Widget build(BuildContext context) {
    void fundCard() =>
        context.push(AppRoutes.virtualCardFund, extra: card.cardId);
    void cardWithdraw() =>
        context.push(AppRoutes.virtualCardWithdraw, extra: card.cardId);
    void cardTransactions() =>
        context.push(AppRoutes.virtualCardTransactions, extra: card.cardId);
    void viewCardDetails() =>
        context.push(AppRoutes.virtualCardDetail, extra: card.cardId);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSpacing.lg),
      // height: 256,
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.xlg / 3.6,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardContainerColor,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(width: 0.041),
      ),
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          Row(
            spacing: AppSpacing.sm,
            children: [
              Expanded(flex: 5, child: VirtualATMCard(card: card)),
              Column(
                spacing: AppSpacing.sm,
                children: [
                  VirtualCardMiniButton(
                    label: 'Fund Card',
                    icon: Assets.icons.addButton.svg(),
                    onTap: fundCard,
                  ),
                  VirtualCardMiniButton(
                    label: AppStrings.withdraw,
                    icon: Assets.icons.transferLine.svg(),
                    onTap: cardWithdraw,
                  ),
                  VirtualCardMiniButton(
                    label: 'Transaction',
                    icon: Assets.icons.history.svg(),
                    onTap: cardTransactions,
                  ),
                ],
              ),
            ],
          ),
          Divider(thickness: 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.sm,
                children: [
                  Text(
                    'Date Created: ${s.formatDateTime(card.createdAt)}',
                    style: TextStyle(
                      fontSize: AppSpacing.sm,
                      fontWeight: AppFontWeight.light,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Status ',
                      style: TextStyle(
                        fontSize: AppSpacing.sm,
                        fontWeight: AppFontWeight.light,
                      ),
                      children: [
                        TextSpan(
                          text: card.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: card.isActive
                                ? AppColors.green
                                : AppColors.red,
                            fontWeight: AppFontWeight.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 130,
                child: AppButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.23),
                    ),
                    backgroundColor: AppColors.buttonColor,
                  ),
                  text: 'View Card Details',
                  textStyle: TextStyle(
                    fontSize: AppSpacing.sm + 1,
                    color: AppColors.white,
                    fontWeight: AppFontWeight.medium,
                  ),
                  onPressed: viewCardDetails,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
