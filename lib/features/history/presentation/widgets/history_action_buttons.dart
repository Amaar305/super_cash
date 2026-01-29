import 'package:flutter/material.dart';
import 'package:super_cash/features/history/presentation/widgets/outline_history_action_button.dart';

class HistoryActionButtons extends StatelessWidget {
  const HistoryActionButtons({
    super.key,
    required this.onDownload,
    required this.onShare,
  });

  final VoidCallback onDownload;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: OutlineHistoryActionButton(
            title: 'Download',
            onPressed: onDownload,
          ),
        ),
        Expanded(
          child: OutlineHistoryActionButton(title: 'Share', onPressed: onShare),
        ),
      ],
    );
  }
}
