import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:super_cash/core/app_strings/app_string.dart';

class CardDetailsSection extends StatelessWidget {
  const CardDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isExpanded = context.select(
      (CardDetailCubit cubit) => cubit.state.isCardDetailsExpanded,
    );
    final cardDetails = context.select(
      (CardDetailCubit cubit) => cubit.state.cardDetails,
    );

    final color = AppColors.blue.withValues(alpha: 0.097);

    return Tappable.faded(
      onTap: context.read<CardDetailCubit>().onCardDetailsExpanded,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isExpanded ? 400 : null,
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.md + 2,
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.sm - 1),
          border: Border.all(color: color),
        ),
        child: Column(
          spacing: AppSpacing.md,
          children: [
            CardCollapsableTile(
              title: AppStrings.cardDetails,
              onTap: context.read<CardDetailCubit>().onCardDetailsExpanded,
              leading: Icon(Icons.info_outline, color: AppColors.blue),
              trailing: CardDropIconButton(
                isExpanded: isExpanded,
                onTap: context.read<CardDetailCubit>().onCardDetailsExpanded,
              ),
            ),
            if (isExpanded) ...[
              CardBorderedContainer(
                child: CardDetailsBillingAddress(
                  billingAddress: cardDetails?.billingAddress,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
