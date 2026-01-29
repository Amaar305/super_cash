import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class OutlineHistoryActionButton extends StatelessWidget {
  const OutlineHistoryActionButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppButton.outlined(
      text: title,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        fixedSize: Size.fromHeight(50),
      ),
    );
  }
}
