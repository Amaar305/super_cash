import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HowItWorksLeading extends StatelessWidget {
  const HowItWorksLeading({super.key, required this.leadingIcon});
  final Widget leadingIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: FittedBox(child: leadingIcon),
    );
  }
}
