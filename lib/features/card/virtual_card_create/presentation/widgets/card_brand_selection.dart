import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../card.dart';

class CardBrandSection extends StatelessWidget {
  const CardBrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMasterCard = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.isMasterCard,
    );
    var borderRadius = BorderRadius.circular(AppSpacing.md - 0.46);

    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.cardBrand,
          style: TextStyle(
            fontSize: AppSpacing.md - 1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        Row(
          spacing: AppSpacing.lg,
          children: [
            CardBrandButton(
              borderRadius: borderRadius,
              selected: isMasterCard,
              onChanged: (val) =>
                  context.read<CreateVirtualCardCubit>().updateCardBrand(val!),
              value: true,
            ),
            CardBrandButton(
              borderRadius: borderRadius,
              selected: isMasterCard,
              onChanged: (val) =>
                  context.read<CreateVirtualCardCubit>().updateCardBrand(val!),
              value: false,
              cardBrandType: CardBrandType.visacard,
            ),
          ],
        ),
      ],
    );
  }
}
