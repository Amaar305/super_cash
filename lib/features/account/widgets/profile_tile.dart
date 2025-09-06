import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.label,
    this.onTap,
    this.leadingIcon,
    this.leadingColor,
    this.subtile,
  });

  final String label;
  final String? subtile;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return Tappable.scaled(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xlg),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.lg - 1),
                color: leadingColor ?? ProfileTileColors.color1,
              ),
              child: leadingIcon,
            ),
            Gap.h(AppSpacing.lg),
            if (subtile != null)
              Column(
                spacing: AppSpacing.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  Text(
                    subtile!,
                    style: TextStyle(
                      fontSize: AppSpacing.md - 2,
                      fontWeight: AppFontWeight.light,
                    ),
                  ),
                ],
              )
            else
              Text(label),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: AppSpacing.md,
            )
          ],
        ),
      ),
    );
  }
}

class ProfileTileColors {
  static Color color1 = Color.fromRGBO(180, 177, 249, 0.4);
  static Color color2 = Color.fromRGBO(239, 236, 250, 1);
  static Color color3 = Color.fromRGBO(243, 236, 250, 1);
  static Color color4 = Color.fromRGBO(250, 236, 243, 1);
  static Color color5 = Color.fromRGBO(250, 236, 243, 1);
  static Color color6 = Color.fromRGBO(250, 236, 236, 1);
}
