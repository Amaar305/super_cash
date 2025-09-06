import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

enum CardBrandType { mastercard, visacard }

class CardBrandButton extends StatelessWidget {
  const CardBrandButton({
    super.key,
    required this.borderRadius,
    required this.selected,
    this.onChanged,
    this.cardBrandType = CardBrandType.mastercard,
    required this.value,
  });

  final BorderRadius borderRadius;
  final bool selected;
  final void Function(bool?)? onChanged;
  final CardBrandType cardBrandType;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final iconImage = switch (cardBrandType) {
      CardBrandType.mastercard => Assets.images.international2.image(),
      _ => Assets.images.visaelectron.image()
    };
    String cardText =
        cardBrandType == CardBrandType.mastercard ? 'MasterCard' : 'Visa Card';
    return Expanded(
      child: Material(
        elevation: 0.8,
        borderRadius: borderRadius,
        child: Container(
          width: double.infinity,
          height: AppSpacing.xxxlg - 9,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.cardContainerColor,
            borderRadius: borderRadius,
          ),
          child: RadioMenuButton(
            value: value,
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: borderRadius),
              ),
              fixedSize: WidgetStatePropertyAll(
                Size.fromHeight(AppSpacing.xxxlg - 9),
              ),
            ),
            groupValue: selected,
            onChanged: onChanged,
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 17,
                  child: iconImage,
                ),
                Gap.h(AppSpacing.xs),
                Text(
                  cardText,
                  style: TextStyle(
                    fontSize: AppSpacing.md - 2,
                    fontWeight: AppFontWeight.regular,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
