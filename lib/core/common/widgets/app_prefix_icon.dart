import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppPrefixIcon extends Icon {
  const AppPrefixIcon(
    super.icon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 20,
      color: AppColors.grey,
    );
  }
}
