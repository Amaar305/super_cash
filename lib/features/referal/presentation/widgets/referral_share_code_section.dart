import 'package:app_ui/app_ui.dart';
import 'package:env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
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
    final phone = context.select(
      (AppCubit element) => element.state.user?.phone ?? '',
    );
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
                      child: Text(phone),
                    ),
                    Tappable.faded(
                      onTap: () {
                        copyText(context, phone, 'Copied');
                      },
                      child: Container(
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
                    ),
                  ],
                ),
                NewWidget(
                  title: 'Android invite link:',
                  link: EnvProd.playStoreUrl,
                ),
                NewWidget(
                  title: 'Apple invite link:',
                  link: EnvProd.appStoreUrl,
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
                      onPressed: () {
                        if (phone.trim().isEmpty) {
                          return;
                        }
                        final message = 'Use my referral code: $phone';
                        final encodedMessage = Uri.encodeComponent(message);
                        launchLink('https://wa.me/?text=$encodedMessage');
                      },
                    ),
                    ReferralShareButton(
                      label: 'Others',
                      backgroudColor: Color(0xff00326D),
                      onPressed: () {
                        if (phone.trim().isEmpty) {
                          return;
                        }
                        final message = [
                          'Use my referral code: $phone',
                          'Android: ${EnvProd.playStoreUrl}',
                          'iOS: ${EnvProd.appStoreUrl}',
                        ].join('\n');
                        Share.share(message, subject: 'Referral Code');
                      },
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
                    Flexible(
                      child: Text(
                        link,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsTextStyle(fontSize: AppSpacing.md),
                      ),
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
                onPressed: () {
                  copyText(context, link, 'Copied');
                },
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
