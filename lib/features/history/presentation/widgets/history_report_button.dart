import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HistoryReportButton extends StatelessWidget {
  const HistoryReportButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(label: 'Report', onPressed: onPressed);
  }
}
