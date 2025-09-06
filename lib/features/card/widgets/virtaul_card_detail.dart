import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared/shared.dart';

class VirtaulCardDetails extends StatelessWidget {
  const VirtaulCardDetails({super.key, this.cardDetails});
  final CardDetails? cardDetails;
  @override
  Widget build(BuildContext context) {
    // final cardDetails = context.select(
    //   (CardDetailCubit cubit) => cubit.state.cardDetails,
    // );

    if (cardDetails == null) {
      return CardContainer(
        scrollable: false,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.grey,
            strokeWidth: AppSpacing.xxs,
          ),
        ),
      );
    }

    return CardContainer(
      isPlatinum: cardDetails?.isPlatinum ?? false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.appName,
                style: TextStyle(
                  fontWeight: AppFontWeight.bold,
                  fontSize: AppSpacing.md,
                  color: AppColors.white,
                ),
              ),
              Row(
                spacing: AppSpacing.sm,
                children: [
                  SizedBox.square(
                    dimension: 40,
                    child: Assets.images.sim.image(),
                  ),
                  SizedBox(
                    child: Assets.icons.wifi.svg(
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap.v(AppSpacing.lg),

          // Gap.v(AppSpacing.md),
          Center(
            child: Text(
              cardNumbers(cardDetails!.cardNumber),
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexMono(
                color: AppColors.white,
                fontSize: 20,
                letterSpacing: 2.5, // Stretch out the spacing
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap.v(AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _cardMiniText(
                title: 'Exp. Date',
                subtitle: cardDetails!.formattedExpiryDate,
              ),
              _cardMiniText(title: 'CVV', subtitle: cardDetails!.cvv),
            ],
          ),
          Gap.v(AppSpacing.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardDetails!.cardName,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.black,
                  fontSize: AppSpacing.lg,
                  color: AppColors.white,
                ),
              ),
              Assets.images.international.image(width: 39.92, height: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardMiniText({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppSpacing.md - 1,
            fontWeight: AppFontWeight.medium,
            color: Color.fromRGBO(224, 224, 223, 1),
          ),
        ),
        Text(
          subtitle,
          style: poppinsTextStyle(
            fontWeight: AppFontWeight.black,
            fontSize: AppSpacing.md,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  String cardNumbers(String numbers) {
    String text = "";

    for (int i = 0; i < numbers.length; i++) {
      if (i != 0 && i % 4 == 0) {
        text += "  ";
      }
      text += numbers[i];
    }

    return text;
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    this.child,
    this.scrollable = true,
    this.isPlatinum = false,
  });

  final Widget? child;
  final bool scrollable;
  final bool isPlatinum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
      child: scrollable ? SingleChildScrollView(child: child) : child,
    );
  }
}
