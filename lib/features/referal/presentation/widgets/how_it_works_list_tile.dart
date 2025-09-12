import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/referal/referal.dart';

class HowItWorksListTile extends StatelessWidget {
  const HowItWorksListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
  });

  final String title;
  final String subtitle;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: HowItWorksLeading(
        leadingIcon: SizedBox.square(dimension: 20, child: leading),
      ),
      title: Text(
        title,
        style: poppinsTextStyle(
          fontSize: AppSpacing.md,
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: poppinsTextStyle(fontSize: AppSpacing.sm),
      ),
    );
  }
}
