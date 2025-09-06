import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class CardTransactionFilterButton extends StatelessWidget {
  const CardTransactionFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onFilterTapped() {
      context.showAdaptiveDialog(builder: (_) => CardTransactionFilterDialog());
    }

    return Container(
      width: 102,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 0.5, color: Color.fromRGBO(197, 198, 204, 1)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onFilterTapped,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ).copyWith(right: AppSpacing.sm),
          child: Row(
            spacing: AppSpacing.sm,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sort, size: 12),
              Text(
                AppStrings.filter,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.deepBlue,
                ),
                alignment: Alignment(0, 0),
                child: FittedBox(
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
