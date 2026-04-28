import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashValidatedAccount extends StatelessWidget {
  const CashValidatedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final val = context.select(
      (CashGiveawayCubit element) =>
          element.state.bankValidationResult?.accountName,
    );
    if (val == null) return SizedBox.shrink();
    return Container(
      height: 56,
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        color: Color(0xffE6E8EA),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              val,
              style: poppinsTextStyle(
                fontWeight: AppFontWeight.medium,
                fontSize: 16,
              ),
            ),
            Icon(Icons.done, color: AppColors.green),
          ],
        ),
      ),
    );
  }
}
