import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:flutter/material.dart';

class ReferalBenefitsSection extends StatelessWidget {
  const ReferalBenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainerInfo(
      infoLabel: 'Referral Benefits',
      child: Column(
        spacing: AppSpacing.sm,
        children:
            [
                  'Refer your friend and earn N1,000 when the prospect upgrades account to an agent’s',
                  'You earn 0.5% on all airtime and direct data purchase your prospect made on CoolData.',
                ]
                .map(
                  (e) => Row(
                    spacing: AppSpacing.xs,
                    children: [
                      Icon(Icons.circle, size: AppSize.iconSizeXSmall / 1.6),
                      Flexible(
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: AppFontWeight.light,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }
}
