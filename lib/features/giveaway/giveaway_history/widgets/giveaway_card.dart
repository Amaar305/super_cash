import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

/////// MAIN CONTAINER  ////
class _GiveawayCardContainer extends StatelessWidget {
  const _GiveawayCardContainer({this.child});
  final Widget? child;

  static final _pirmaryColor = AppColors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.white,
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

////
class GiveawayCard extends StatelessWidget {
  const GiveawayCard({super.key, required this.giveawayHistory});
  final GiveawayHistory giveawayHistory;

  @override
  Widget build(BuildContext context) {
    final suffixText = giveawayHistory.giveawayType.name.capitalize;
    final altText =
        giveawayHistory.giveawayType.code == 'airtime-pin' ||
            giveawayHistory.giveawayType.code.contains('data')
        ? giveawayHistory.network
        : 'Product';
    return _GiveawayCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          Row(
            spacing: AppSpacing.md,
            children: [
              getNetworkImage(giveawayHistory.network, width: 48, height: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₦${giveawayHistory.amount} $suffixText',
                      style: poppinsTextStyle(
                        fontSize: 12,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ),

                    Text(
                      '${dateAgo(giveawayHistory.createdAt)} • $altText',
                      style: poppinsTextStyle(
                        fontSize: 10,
                        color: _GiveawayCardContainer._pirmaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              _ClaimedBadge(),
            ],
          ),
          if (giveawayHistory.giveawayType.code == 'airtime-pin') ...[
            _divider(),
            GiveawayPinSection(giveawayHistory: giveawayHistory),
          ],
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(
      thickness: 0.6,
      color: _GiveawayCardContainer._pirmaryColor.withValues(alpha: 0.3),
    );
  }
}

class GiveawayPinSection extends StatefulWidget {
  const GiveawayPinSection({super.key, required this.giveawayHistory});
  final GiveawayHistory giveawayHistory;

  @override
  State<GiveawayPinSection> createState() => _GiveawayPinSectionState();
}

class _GiveawayPinSectionState extends State<GiveawayPinSection> {
  GiveawayHistory get gHistory => widget.giveawayHistory;
  AirtimeGiveawayPin get aPin => gHistory.giveawayPin;

  bool _showPin = false;
  void _togglePin() => setState(() {
    _showPin = !_showPin;
  });
  void dial(AirtimeGiveawayPin pin) {
    final dial = pin.loadingCode ?? '*311*${pin.maskedPin}#';
    dialNumber(dial);
  }

  void copy(pin) {
    copyText(context, pin, 'Copied');
  }

  @override
  Widget build(BuildContext context) {
    final icon = _showPin ? Icons.visibility_off : Icons.visibility_outlined;

    final text = _showPin ? aPin.maskedPin : "****  ****  **** ****  ****";

    return Container(
      width: context.screenWidth * 0.8,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _GiveawayCardContainer._pirmaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.lg,
        children: [
          newMethod(icon: icon, text: text),
          Row(
            spacing: AppSpacing.lg,
            children: [
              Expanded(child: _DialButton(onTap: () => dial(aPin))),
              _CopyButton(onCopy: () => copy(aPin.maskedPin)),
            ],
          ),
        ],
      ),
    );
  }

  Container newMethod({required String text, required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        color: _GiveawayCardContainer._pirmaryColor.withValues(alpha: 0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(
            child: Text(
              text,
              style: poppinsTextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.bold,
              ).copyWith(letterSpacing: 1.5, height: 1.5),
            ),
          ),
          Tappable.faded(
            onTap: _togglePin,
            child: Icon(
              icon,
              size: 16,
              color: _GiveawayCardContainer._pirmaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

//// COMPONENTS  ////
class _CopyButton extends StatelessWidget {
  const _CopyButton({this.onCopy});
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onCopy,
      child: Container(
        width: 66,
        height: 43,
        // padding: EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.grey.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        child: Center(
          child: Icon(Icons.copy, size: 18, color: AppColors.white),
        ),
      ),
    );
  }
}

class _DialButton extends StatelessWidget {
  const _DialButton({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: 32,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          _GiveawayCardContainer._pirmaryColor,
        ),
        fixedSize: WidgetStatePropertyAll(Size(190, 32)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
        ),
      ),
      text: '',
      onPressed: onTap,
      icon: Icon(Icons.phone_outlined, color: AppColors.white),
      child: Text(
        'Dial Pin',
        style: poppinsTextStyle(
          fontSize: 12,
          color: AppColors.white,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}

class _ClaimedBadge extends StatelessWidget {
  const _ClaimedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _GiveawayCardContainer._pirmaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Text(
        'Claimed',
        style: poppinsTextStyle(
          fontSize: 11,
          fontWeight: AppFontWeight.bold,
          color: _GiveawayCardContainer._pirmaryColor,
        ),
      ),
    );
  }
}
