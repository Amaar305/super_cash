import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.illustration,
    this.action,
    this.padding,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final Widget? illustration;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accentColor = colorScheme.primary;
    final bodyColor = colorScheme.onSurface.withValues(alpha: 0.7);

    final Widget visual =
        illustration ??
        Container(
          height: 96,
          width: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                accentColor.withValues(alpha: 0.15),
                accentColor.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon ?? Icons.checklist_outlined,
            color: accentColor,
            size: 40,
          ),
        );

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: AppSpacing.xlg,
                vertical: AppSpacing.lg,
              ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              color: colorScheme.surface,
              
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xxlg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  visual,
                  Gap.v(AppSpacing.md),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: poppinsTextStyle(
                      fontSize: AppSpacing.lg,
                      fontWeight: AppFontWeight.semiBold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (description != null) ...[
                    Gap.v(AppSpacing.sm),
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: poppinsTextStyle(
                        fontSize: AppSpacing.sm,
                        fontWeight: AppFontWeight.regular,
                        color: bodyColor,
                      ),
                    ),
                  ],
                  if (action != null) ...[Gap.v(AppSpacing.lg), action!],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
