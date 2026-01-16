import 'package:app_ui/app_ui.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class HomeAccountDetailWidget extends StatelessWidget {
  const HomeAccountDetailWidget({
    super.key,
    required this.accountName,
    required this.accountNumber,
  });

  final String accountName;
  final String accountNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.sm,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  accountNumber,
                  style: poppinsTextStyle(
                    color: AppColors.white,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  accountName,
                  style: poppinsTextStyle(
                    color: AppColors.white,
                    fontWeight: AppFontWeight.regular,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            Tappable.scaled(
              onTap: () {
                // Handle copy action
                
                copyText(
                  context,
                  accountNumber,
                  'Account number copied to clipboard',
                );
              },
              child: SizedBox.square(
                dimension: 18,
                child: Assets.icons.copy.svg(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
