import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class AssistanceButton extends StatelessWidget {
  const AssistanceButton({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Tappable.scaled(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          const Icon(
            Icons.headset_mic_outlined,
            size: 18,
            color: AppColors.blue,
          ),
          Center(
            child: Text.rich(
              TextSpan(
                text: AppStrings.authHelp,
                children: [
                  TextSpan(
                    text: AppStrings.authHelpText,
                    style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.blue,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
