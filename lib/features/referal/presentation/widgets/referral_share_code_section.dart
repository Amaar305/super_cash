import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/card/card_details/presentation/widgets/card_drop_icon_button.dart';
import 'package:super_cash/features/referal/referal.dart';

import '../../../card/widgets/card_collapsable_tile.dart';

class ReferralShareCodeSection extends StatefulWidget {
  const ReferralShareCodeSection({super.key});

  @override
  State<ReferralShareCodeSection> createState() =>
      _ReferralShareCodeSectionState();
}

class _ReferralShareCodeSectionState extends State<ReferralShareCodeSection> {
  bool isExpanded = false;

  void toggle() => setState(() {
    isExpanded = !isExpanded;
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tappable.faded(
          onTap: toggle,
          child: CardCollapsableTile(
            leading: Icon(Icons.info_outline, color: AppColors.blue),
            trailing: CardDropIconButton(isExpanded: isExpanded, onTap: toggle),
            title: 'Referral Info',
            onTap: toggle,
          ),
        ),
        if (isExpanded)
          ReferralShareCodeItem(key: ValueKey('show_referral_code')),
      ],
    );
  }
}

class ReferralShareCodeItem extends StatelessWidget {
  const ReferralShareCodeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Assets.images.coinsAmico1.image(width: 113),
        Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.blue.withValues(alpha: 0.05),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.md + 2,
              children: [
                Text(
                  'Your Referral Code',
                  textAlign: TextAlign.center,
                  style: poppinsTextStyle(
                    fontSize: AppSpacing.lg,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.md,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 19,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                        border: Border.all(width: 0.5),
                      ),
                      child: Text('share.makanrealty/ref-013'),
                    ),
                    Container(
                      // height: 37,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 19,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                        border: Border.all(width: 0.5),
                      ),

                      child: Icon(
                        Icons.copy_outlined,
                        size: 20,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                NewWidget(
                  title: 'Android invite link:',
                  link: 'https://app/playstore/share/invite',
                ),
                NewWidget(
                  title: 'Apple invite link:',
                  link: 'https://app/playstore/share/invite',
                ),
                Text(
                  'Share your referrel code via',
                  textAlign: TextAlign.center,
                  style: poppinsTextStyle(fontSize: AppSpacing.md),
                ),
                Row(
                  spacing: AppSpacing.md,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReferralShareButton(
                      label: 'Whatsapp',
                      backgroudColor: Color(0xff51A530),
                      onPressed: () {},
                    ),
                    ReferralShareButton(
                      label: 'Others',
                      backgroudColor: Color(0xff00326D),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.title,
    required this.link,
    this.onPressed,
  });

  final String title;
  final String link;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(title, style: poppinsTextStyle(fontSize: AppSpacing.md)),
        Container(
          height: 48,
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xs,
                  children: [
                    Icon(
                      Icons.link_rounded,
                      color: AppColors.grey,
                      size: AppSpacing.lg,
                    ),
                    Text(
                      link,
                      style: poppinsTextStyle(fontSize: AppSpacing.md),
                    ),
                  ],
                ),
              ),
              AppButton(
                text: 'Copy',
                textStyle: poppinsTextStyle(
                  color: AppColors.white,
                  fontSize: AppSpacing.md,
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(69, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(AppSpacing.xlg),
                  ),
                  backgroundColor: AppColors.background3,
                  padding: EdgeInsets.all(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
