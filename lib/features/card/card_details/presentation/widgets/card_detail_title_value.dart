import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardDetailTitleWithValue extends StatelessWidget {
  const CardDetailTitleWithValue({
    super.key,
    required this.title,
    this.value,
    this.isCopyable = true,
    this.boldValue = false,
  });
  final String title;
  final String? value;
  final bool isCopyable;
  final bool boldValue;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: AppSpacing.md + 1,
                      fontWeight: AppFontWeight.light,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value ?? '',
                    style: TextStyle(
                      fontSize: AppSpacing.md,
                      fontWeight: boldValue
                          ? AppFontWeight.extraBold
                          : AppFontWeight.light,
                    ),
                  ),
                  const Gap.h(AppSpacing.sm),
                  if (isCopyable)
                    Tappable.faded(
                      onTap: () {
                        copyText(context, value ?? '', '$title copied');
                      },
                      child: Assets.icons.copy.svg(
                        // ignore: deprecated_member_use
                        color: AppColors.buttonColor,
                      ),
                    ),
                ],
              ),
              const Divider(thickness: 0.3),
            ],
          ),
        );
      },
    );
  }
}
