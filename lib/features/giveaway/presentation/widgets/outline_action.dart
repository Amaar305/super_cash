import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class OutlineAction extends StatelessWidget {
  const OutlineAction({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onTap,

      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1.2, color: Color(0xFFE6ECEF)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: iconColor ?? AppColors.blue),
            const SizedBox(width: 10),
            Text(
              label,
              style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
            ),
          ],
        ),
      ),
    );
  }
}
