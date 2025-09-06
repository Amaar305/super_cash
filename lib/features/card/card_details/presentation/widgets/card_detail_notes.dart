import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/widgets/app_container_info.dart';
import 'package:flutter/material.dart';

class CardDetailNotes extends StatelessWidget {
  const CardDetailNotes({super.key});

  final List<Widget> _notes = const [
    Text.rich(
      TextSpan(
        text: 'Available Balance ',
        style: TextStyle(
          color: AppColors.blue,
          fontWeight: AppFontWeight.semiBold,
          fontSize: AppSpacing.md - 1,
        ),
        children: [
          TextSpan(
            text:
                'is the amount you can use to make payments across different platforms, ',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: AppFontWeight.regular,
            ),
          ),
          TextSpan(
            text: 'not ',
            style: TextStyle(
              color: AppColors.red,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          TextSpan(
            text: 'Total Balance.',
            style: TextStyle(
              color: AppColors.blue,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        text: 'Ensure to have sufficient ',
        style: TextStyle(
          color: AppColors.buttonColor,
          fontWeight: AppFontWeight.regular,
          fontSize: AppSpacing.md - 1,
        ),
        children: [
          TextSpan(
            text: 'Available Balance, ',
            style: TextStyle(
              color: AppColors.blue,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          TextSpan(text: 'to cover for your transaction amount and charges.'),
        ],
      ),
    ),
    Text(
      'Declined Transactions due to insufficient balance may incur some charges.',
      style: TextStyle(
        color: AppColors.buttonColor,
        fontWeight: AppFontWeight.regular,
        fontSize: AppSpacing.md - 1,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return AppContainerInfo(
      infoLabel: 'Note',
      child: Column(
        spacing: AppSpacing.xs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _notes
            .map(
              (note) => Row(
                spacing: AppSpacing.sm,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                // mainAxisAlignment: MainAxisAlignment.start,
                // textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: AppColors.buttonColor,
                    size: AppSize.iconSizeXSmall / 1.6,
                  ),
                  Flexible(child: note),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
