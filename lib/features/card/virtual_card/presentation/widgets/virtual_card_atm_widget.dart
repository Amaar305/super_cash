import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart' as s;

class VirtualCardContainer extends StatelessWidget {
  const VirtualCardContainer({
    super.key,
    required this.isPlatinum,
    this.width,
    this.child,
  });
  const VirtualCardContainer.widthInfinity({
    Key? key,
    required bool isPlatinum,
    double? width,
    Widget? child,
  }) : this(
         key: key,
         isPlatinum: isPlatinum,
         width: double.infinity,
         child: child,
       );

  final bool isPlatinum;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 224.35,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.55),
        gradient: LinearGradient(
          colors: isPlatinum
              ? AppColors.platinumBackgroundGradient
              : AppColors.virtualCardGradient,
        ),
        image: isPlatinum
            ? null
            : DecorationImage(
                image: Assets.images.bgp.provider(),
                fit: BoxFit.cover,
              ),
      ),
      child: child,
    );
  }
}

class VirtualATMCard extends StatelessWidget {
  const VirtualATMCard({super.key, this.width, required this.card});
  final s.Card card;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final mastercardIcon = switch (card.isPlatinum) {
      true => Assets.images.international2.image(width: 29.92, height: 22.92),
      _ => Assets.images.international.image(width: 29.92, height: 22.92),
    };

    final mastercardText = card.isPlatinum
        ? 'PLATINUM MASTERCARD'
        : 'MASTERCARD';
    final cardLimitText = card.isPlatinum
        ? '\$10,000 Monthly Limit'
        : '\$5,000 Monthly Limit';

    final cardTextColor = card.isPlatinum ? null : AppColors.white;
    return VirtualCardContainer(
      isPlatinum: card.isPlatinum,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          Text(
            AppStrings.appCardName,
            style: TextStyle(
              fontSize: AppSpacing.md + 0.19 - 2,
              fontWeight: AppFontWeight.black,
              color: cardTextColor,
            ),
          ),
          Gap.v(AppSpacing.xxs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.images.sim.image(width: 24.14, height: 19.1),
              Assets.icons.wifi.svg(),
            ],
          ),
          Text.rich(
            TextSpan(
              text: mastercardText,
              style: TextStyle(
                fontWeight: AppFontWeight.bold,
                color: cardTextColor,
                fontSize: AppSpacing.md + 0.19 - 2,
              ),
              children: [
                TextSpan(
                  text: ' (VIRTUAL CARD)',
                  style: TextStyle(fontSize: AppSpacing.sm + 0.25 - 2),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardLimitText,
                style: TextStyle(
                  fontSize: AppSpacing.sm + 0.91,
                  color: cardTextColor,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
              mastercardIcon,
            ],
          ),
        ],
      ),
    );
  }
}

class VirtualATMCreateCard extends StatelessWidget {
  const VirtualATMCreateCard({super.key, this.cardBrand = false, this.onTap});
  final bool cardBrand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mastercardIcon = switch (cardBrand) {
      true => Assets.images.international2.image(width: 45, height: 20),
      _ => Assets.images.visaelectron.image(
        width: 45,
        height: 20,
        color: AppColors.white,
      ),
    };

    final mastercardText = cardBrand ? 'MASTERCARD' : 'VISA';
    final cardLimitText = '\$5,000 Monthly Limit';
    final cardTextColor = AppColors.white;

    return Tappable.faded(
      onTap: onTap,
      child: VirtualCardContainer.widthInfinity(
        isPlatinum: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            Text(
              AppStrings.appCardName,
              style: TextStyle(
                fontSize: AppSpacing.md + 0.19 - 2,
                fontWeight: AppFontWeight.black,
                color: cardTextColor,
              ),
            ),
            Gap.v(AppSpacing.xxs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.images.sim.image(width: 24.14, height: 19.1),
                Assets.icons.wifi.svg(),
              ],
            ),
            Gap.v(AppSpacing.xxs),
            Text.rich(
              TextSpan(
                text: mastercardText,
                style: TextStyle(
                  fontWeight: AppFontWeight.bold,
                  color: cardTextColor,
                  fontSize: AppSpacing.md + 0.19 - 2,
                ),
                children: [
                  TextSpan(
                    text: ' (VIRTUAL CARD)',
                    style: TextStyle(fontSize: AppSpacing.sm + 0.25 - 2),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardLimitText,
                  style: TextStyle(
                    fontSize: AppSpacing.sm + 0.91,
                    color: cardTextColor,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
                mastercardIcon,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VirtualPlatinumCard extends StatelessWidget {
  const VirtualPlatinumCard({super.key, required this.cardBrand, this.onTap});
  final bool cardBrand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mastercardIcon = switch (cardBrand) {
      true => Assets.images.international2.image(width: 45, height: 20),
      _ => Assets.images.visaelectron.image(
        width: 45,
        height: 20,
        color: AppColors.white,
      ),
    };
    final cardLimitText = '\$10,000 Monthly Limit';

    final mastercardText = cardBrand ? 'PLATINUM MASTERCARD' : 'VISA';

    return Tappable.faded(
      onTap: onTap,
      child: VirtualCardContainer.widthInfinity(
        isPlatinum: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            Text(
              AppStrings.appCardName,
              style: TextStyle(
                fontSize: AppSpacing.md + 0.19 - 2,
                fontWeight: AppFontWeight.black,
              ),
            ),
            Gap.v(AppSpacing.xxs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.images.sim.image(width: 24.14, height: 19.1),
                Assets.icons.wifi.svg(),
              ],
            ),
            Gap.v(AppSpacing.xxs),
            Text.rich(
              TextSpan(
                text: mastercardText,
                style: TextStyle(
                  fontWeight: AppFontWeight.bold,
                  fontSize: AppSpacing.md + 0.19 - 2,
                ),
                children: [
                  TextSpan(
                    text: ' (VIRTUAL CARD)',
                    style: TextStyle(fontSize: AppSpacing.sm + 0.25 - 2),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardLimitText,
                  style: TextStyle(
                    fontSize: AppSpacing.sm + 0.91,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
                mastercardIcon,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
