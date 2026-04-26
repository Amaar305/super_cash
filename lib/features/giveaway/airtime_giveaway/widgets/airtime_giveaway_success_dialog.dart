import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AirtimeGiveawaySuccessDialog extends StatefulWidget {
  const AirtimeGiveawaySuccessDialog({
    super.key,
    required this.airtimeGiveawayPin,
  });
  final AirtimeGiveawayPin airtimeGiveawayPin;

  @override
  State<AirtimeGiveawaySuccessDialog> createState() =>
      _AirtimeGiveawaySuccessDialogState();
}

class _AirtimeGiveawaySuccessDialogState
    extends State<AirtimeGiveawaySuccessDialog> {
  bool _showPin = false;

  void togglePin() => setState(() {
    _showPin = !_showPin;
  });

  void dial() {
    final dial = _pin.loadingCode ?? '*311*${_pin.maskedPin}#';
    dialNumber(dial);
  }

  void copy() {
    copyText(context, _pin.maskedPin, 'Copied');
  }

  AirtimeGiveawayPin get _pin => widget.airtimeGiveawayPin;

  @override
  Widget build(BuildContext context) {
    final pinText = _showPin ? _pin.maskedPin : '*********';

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.67,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              AppSpacing.lg,
            ).copyWith(top: AppSpacing.xlg),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.close, color: AppColors.black, size: 20),
                  ),
                ).animate().fadeIn().scale(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outlined,
                      color: AppColors.black,
                      size: 70,
                    ),
                    Gap.v(AppSpacing.lg),
                    Text(
                      'Congratulations!',
                      style: poppinsTextStyle(
                        fontSize: 20,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ),
                    Gap.v(AppSpacing.sm),
                    Text(
                      "You've successfully claimed your airtime reward!",
                      textAlign: TextAlign.center,
                      style: poppinsTextStyle(fontSize: 12),
                    ),
                    Gap.v(AppSpacing.lg),
                    Assets.images.mtn.image(width: 43, height: 43),
                    Gap.v(AppSpacing.sm),

                    Text(
                      '₦${_pin.amount}',
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: 24,
                      ),
                    ),
                    Gap.v(AppSpacing.lg),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSpacing.lg),
                      color: Color(0xffEBF8FF),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: AppSpacing.sm,
                        children: [
                          Text(
                            'Your Recharge PIN',
                            style: poppinsTextStyle(
                              fontSize: 12,
                              fontWeight: AppFontWeight.medium,
                            ),
                          ),
                          DottedBorder(
                            dashPattern: [5, 5],
                            radius: Radius.circular(12),
                            color: AppColors.black,

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 200,
                                padding: EdgeInsets.all(AppSpacing.sm),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Center(
                                  child: Row(
                                    spacing: AppSpacing.md,
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Flexible(
                                        child: Text(
                                          pinText,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: poppinsTextStyle(
                                            fontSize: 18,
                                            fontWeight: AppFontWeight.semiBold,
                                          ),
                                        ),
                                      ),
                                      Tappable.faded(
                                        onTap: togglePin,
                                        child: Icon(
                                          _showPin
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap.v(AppSpacing.lg),
                    Row(
                      spacing: AppSpacing.lg,
                      children: [
                        Expanded(
                          child: AppButton.outlined(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fixedSize: Size.fromHeight(48),
                            ),
                            text: 'Copy',
                            onPressed: copy,
                            child: Row(
                              spacing: AppSpacing.sm,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.copy_outlined),
                                Text(
                                  'Copy',
                                  style: poppinsTextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fixedSize: Size.fromHeight(48),
                              backgroundColor: AppColors.black,
                            ),
                            text: 'Copy',
                            onPressed: dial,

                            child: Row(
                              spacing: AppSpacing.sm,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.white,
                                ),
                                Text(
                                  'Dial PIN',
                                  style: poppinsTextStyle(
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap.v(AppSpacing.lg),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpacing.sm,

                        children: [
                          Text(
                            'How to use:',
                            style: poppinsTextStyle(
                              fontSize: 12,
                              fontWeight: AppFontWeight.bold,
                            ),
                          ),

                          Text(
                            'Dial *311*PIN#*  or *134*PIN#',
                            style: poppinsTextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
