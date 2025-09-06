import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class ForMySelfButton extends StatelessWidget {
  const ForMySelfButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.primary2,
          ),
          onPressed: onTap,
          child: Text(
            AppStrings.forMySelf,
            style: TextStyle(fontSize: 10, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
