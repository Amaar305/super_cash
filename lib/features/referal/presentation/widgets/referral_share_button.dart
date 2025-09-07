import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ReferralShareButton extends StatelessWidget {
  const ReferralShareButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.backgroudColor,
  });
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroudColor;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      text: label,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        fixedSize: Size(134, 38),
        backgroundColor: backgroudColor,
      ),
    );
  }
}
