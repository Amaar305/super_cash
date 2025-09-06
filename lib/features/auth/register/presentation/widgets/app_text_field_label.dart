import 'package:flutter/material.dart';

class AppTextFieldLabel extends StatelessWidget {
  const AppTextFieldLabel(
    this.text, {
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
