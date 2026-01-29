import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class HistoryDetailHeader extends StatelessWidget {
  const HistoryDetailHeader({super.key, required this.transaction});

  final TransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            Assets.images.logo.image(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: poppinsTextStyle(
                    fontSize: context.titleMedium?.fontSize,
                  ),
                ),
                Text(
                  'A Product of Cool Data',
                  style: poppinsTextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Receipt',
              style: poppinsTextStyle(
                fontWeight: AppFontWeight.semiBold,
                fontSize: AppSpacing.md,
              ),
            ),
            Row(
              children: [
                Text(
                  formatDateTime(transaction.createdAt),
                  style: poppinsTextStyle(fontSize: 10),
                ),
                // Text(
                //   formatDateTime(transaction.createdAt).split(',').last,
                //   style: poppinsTextStyle(
                //     fontSize: 10,
                //     fontWeight: AppFontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
