import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class FieldLabelTitle extends StatelessWidget {
  const FieldLabelTitle(this.label, {super.key});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: poppinsTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
