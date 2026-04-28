import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AddCashAccountDetailSheet extends StatelessWidget {
  const AddCashAccountDetailSheet({super.key, required this.cashItem});
  final CashGiveawayItem cashItem;

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
                onPressed: () {
                  context.pop(null);
                },
              ),
            ),
            Gap.v(AppSpacing.lg),
            _Header(cashItem: cashItem),
            Gap.v(AppSpacing.xlg),
            CashAccountDetailForm(cashItem: cashItem),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.cashItem});

  final CashGiveawayItem cashItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 123,
      padding: EdgeInsets.all(AppSpacing.xlg),
      decoration: BoxDecoration(
        color: Color(0xFFF2F4F6),
        borderRadius: BorderRadius.circular(AppSpacing.xlg),
      ),
      child: Column(
        spacing: 7,
        children: [
          Text(
            'YOU ARE CLAIMING',
            style: poppinsTextStyle(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 12,
              color: Color(0XFF45464D),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.xs,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₦',
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.extraBold,
                  fontSize: 30,
                ),
              ),
              Text(
                cashItem.amountFixed,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.extraBold,
                  fontSize: 48,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
