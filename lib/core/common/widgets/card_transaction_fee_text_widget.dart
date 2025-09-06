import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/widgets.dart';

Text cardTransactionDescSmallText(String text) {
  return Text(
    text,
    style: poppinsTextStyle(
      fontSize: AppSpacing.md - 2,
      fontWeight: AppFontWeight.regular,
    ),
  );
}

Text cardTransactionDescText(String text) {
  return Text(
    text,
    style: poppinsTextStyle(
      fontSize: AppSpacing.md - 2,
      fontWeight: AppFontWeight.medium,
    ),
  );
}
