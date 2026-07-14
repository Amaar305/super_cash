import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/giveaway/presentation/widgets/giveaway_rules_sheet.dart';

/// A compact, non-blocking disclosure shown on the giveaways list clarifying
/// that giveaways are run by Super Cash and are not affiliated with Apple,
/// with a tap-through to the full [showGiveawayRulesSheet].
class GiveawayDisclaimerNotice extends StatelessWidget {
  const GiveawayDisclaimerNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(
      fontSize: 11,
      height: 1.4,
      color: AppColors.emphasizeGrey,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Icon(
          Icons.info_outline_rounded,
          size: 14,
          color: AppColors.emphasizeGrey,
        ),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Not affiliated with Apple Inc. or the App Store. ',
                style: bodyStyle,
              ),
              Tappable.scaled(
                onTap: () => showGiveawayRulesSheet(context),
                child: Text(
                  'Rules & Terms',
                  style: bodyStyle.copyWith(
                    color: AppColors.blue,
                    fontWeight: AppFontWeight.semiBold,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
