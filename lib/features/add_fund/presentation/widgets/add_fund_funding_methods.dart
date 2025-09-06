import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class AddFundFundingMethods extends StatelessWidget {
  const AddFundFundingMethods({
    super.key,
    required this.selectedIndex,
    this.onChanged,
  });

  final int selectedIndex;
  final void Function(int)? onChanged;

  getText(int index) {
    final text = switch (index) {
      0 => 'Bank Transfer',
      1 => 'Bank Transfer (One-Time)',
      2 => 'Card Funding',
      _ => 'Manual Funding',
    };
    return text;
  }

  Color getActiveBgColor(int index) {
    final color = switch (index) {
      0 => AppColors.deepBlue,
      1 => Color(0xFF00AF91),
      2 => AppColors.buttonColor,
      3 => Color.fromRGBO(255, 95, 0, 1),
      _ => AppColors.white,
    };

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 15,
        childAspectRatio: 3.1,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => Tappable.faded(
        throttle: true,
        throttleDuration: 200.ms,
        onTap: () {
          onChanged?.call(index);
        },
        child: AnimatedContainer(
          duration: 200.ms,
          padding: EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 16,
          ).copyWith(left: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: selectedIndex == index
                ? getActiveBgColor(index)
                : AppColors.white,
            border: selectedIndex == index
                ? null
                : Border.all(color: AppColors.brightGrey),
          ),
          child: Row(
            spacing: AppSpacing.md,
            children: [
              Container(
                height: 24,
                width: 2,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.white
                      : getActiveBgColor(index),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              Flexible(
                child: Text(
                  getText(index),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // style: context.bodySmall?.copyWith(
                  //   // fontWeight: AppFontWeight.regular,
                  //   color: selectedIndex == index ? AppColors.white : null,
                  // ),
                  style: poppinsTextStyle(
                    fontSize: 12,
                    fontWeight: AppFontWeight.regular,
                    color: selectedIndex == index
                        ? AppColors.white
                        : AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
