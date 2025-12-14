import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardBillingAddressSection extends StatelessWidget {
  const CardBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDetailCubit, CardDetailState>(
      builder: (context, state) {
        final cubit = context.read<CardDetailCubit>();
        final billingAddress = state.appleProduct
            ? state.appleBillingAddress
            : state.cardDetails?.billingAddress;
        final expanded = state.isCardBillingAddressExpanded;

        final color = expanded
            ? AppColors.blue
            : AppColors.blue.withValues(alpha: 0.097);

        return Tappable.faded(
          onTap: cubit.onCardBillingAddressExpanded,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: state.isCardBillingAddressExpanded ? 500 : null,
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.md + 2,
              horizontal: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.sm - 1),
              border: Border.all(color: color),
            ),
            child: Column(
              spacing: AppSpacing.sm,
              children: [
                CardCollapsableTile(
                  title: AppStrings.billingAddress,
                  onTap: cubit.onCardBillingAddressExpanded,
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.blue,
                  ),
                  trailing: CardDropIconButton(
                    isExpanded: state.isCardBillingAddressExpanded,
                    onTap: cubit.onCardBillingAddressExpanded,
                  ),
                ),
                if (state.isCardBillingAddressExpanded) ...[
                  const Gap.v(AppSpacing.md),
                  const CardAppleProductSwitchSection(),
                  const Gap.v(AppSpacing.md),
                  CardBorderedContainer(
                    child: CardDetailsBillingAddress(
                      billingAddress: billingAddress,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
