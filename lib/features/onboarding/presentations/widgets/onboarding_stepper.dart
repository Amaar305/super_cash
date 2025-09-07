import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class OnboardingStepper extends StatelessWidget {
  const OnboardingStepper({super.key, required this.currentIndex, required this.length});

  final int currentIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        spacing: 12,
        children: List.generate(
          length,
          (index) => Expanded(
            child: Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: index <= currentIndex
                    ? AppColors.primary2
                    : AppColors.brightGrey,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
