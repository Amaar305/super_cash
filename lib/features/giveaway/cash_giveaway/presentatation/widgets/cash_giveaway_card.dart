import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashGiveawayCard extends StatelessWidget {
  const CashGiveawayCard({
    super.key,
    required this.cash,
    required this.onClaimed,
  });
  final CashGiveawayItem cash;
  final ValueChanged<CashGiveawayItem> onClaimed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(right: -50, top: -50, child: _pattern()),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.xlg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            border: Border.all(color: Colors.black.withValues(alpha: 0.01)),
            color: AppColors.white.withValues(alpha: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.sm,
            children: [
              _Header(amount: cash.amountFixed),
              _Description(title: cash.cashName, description: cash.description),
              Gap.v(AppSpacing.xlg),
              CashGiveawayPercent(cashGiveawayItem: cash),
              Gap.v(AppSpacing.lg),
              CashClaimButton(
                onPressed: () => onClaimed(cash),
                isAvailable: cash.isAvailable,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _pattern() {
    return Container(
      width: 256,
      height: 256,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(9999),
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffFEF08A).withValues(alpha: 0.5)],
        ),
      ),
    );
  }
}

class CashGiveawayPercent extends StatelessWidget {
  const CashGiveawayPercent({super.key, required this.cashGiveawayItem});

  final CashGiveawayItem cashGiveawayItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remaining',
              style: poppinsTextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            Text(
              '${cashGiveawayItem.cashQuantityRemaining} of ${cashGiveawayItem.cashQuantity}',
              style: poppinsTextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 8,
          child: LinearProgressIndicator(
            value:
                (cashGiveawayItem.cashQuantity -
                    cashGiveawayItem.cashQuantityRemaining) /
                cashGiveawayItem.cashQuantity,
            borderRadius: BorderRadius.circular(9999),
            color: Color(0xFFCA8A04),
          ),
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.sm,
          children: [
            Expanded(
              child: Text(
                title,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.extraBold,
                  fontSize: 24,
                ),
              ),
            ),
            Icon(Icons.local_activity, color: Color(0xffEAB308)),
          ],
        ),
        Text(
          description,
          style: poppinsTextStyle(
            fontSize: 12,
            fontWeight: AppFontWeight.light,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.amount});
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatusPill(),
        Text(
          'N$amount',
          style: poppinsTextStyle(
            fontSize: 24,
            fontWeight: AppFontWeight.black,
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill();

  @override
  Widget build(BuildContext context) {
    final color = Color(0xff854D0E);
    return Container(
      width: 102,
      height: 26,
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Color(0xffFEF9C3),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: Color(0xffFEF9C3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: FittedBox(
        child: Center(
          child: Row(
            spacing: 2.17,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flash_auto, size: 10, color: color),
              Text(
                'Instant Drop',
                style: poppinsTextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
