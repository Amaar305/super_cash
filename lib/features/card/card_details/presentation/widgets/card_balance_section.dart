import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/card/card.dart';

class CardBalanceSection extends StatefulWidget {
  const CardBalanceSection({super.key});

  @override
  State<CardBalanceSection> createState() => _CardBalanceSectionState();
}

class _CardBalanceSectionState extends State<CardBalanceSection> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = isExpanded
        ? AppColors.blue
        : AppColors.blue.withValues(alpha: 0.097);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.md + 2,
        horizontal: AppSpacing.md,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.sm - 1),
        border: Border.all(color: color),
      ),

      child: Column(
        children: [
          Tappable.faded(
            onTap: toggleExpanded,
            child: CardCollapsableTile(
              title: AppStrings.cardBalance,
              onTap: toggleExpanded,
              leading: Icon(Icons.balance_outlined, color: AppColors.blue),
              trailing: CardDropIconButton(
                isExpanded: isExpanded,
                onTap: toggleExpanded,
              ),
            ),
          ),

          if (isExpanded) ...[
            Gap.v(AppSpacing.md),
            CardBorderedContainer(height: null, child: CardBalanceDetails()),
          ],
        ],
      ),
    );
  }
}

class CardBalanceDetails extends StatelessWidget {
  const CardBalanceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cardDetails = context.select(
      (CardDetailCubit cubit) => cubit.state.cardDetails,
    );

    if (cardDetails == null) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        CardDetailTitleWithValue(
          title: AppStrings.availableBalance,
          value: '\$${cardDetails.balance.toStringAsFixed(2)}',
          isCopyable: false,
          boldValue: true,
        ),
        CardDetailTitleWithValue(
          title: AppStrings.currentBalance,
          value: '\$${cardDetails.availableBalance.toStringAsFixed(2)}',
          isCopyable: false,
          boldValue: true,
        ),
      ],
    );
  }
}

class BalanceTitle extends StatelessWidget {
  const BalanceTitle({super.key, required this.title, required this.amount});
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: AppFontWeight.medium,
            // color: Color.fromRGBO(224, 224, 223, 1),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: poppinsTextStyle(
            fontWeight: AppFontWeight.black,
            fontSize: AppSpacing.md,
            // color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
