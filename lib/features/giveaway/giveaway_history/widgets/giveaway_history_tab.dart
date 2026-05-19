import 'package:flutter/material.dart';
import 'package:super_cash/core/common/common.dart';

class GiveawayHistoryTab extends StatelessWidget {
  const GiveawayHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTab(
      backgroundColor: const Color(0xFF2F2E2E),
      children: [
        AppTabItem(label: 'Airtime', onTap: () {}, activeTab: true),
        AppTabItem(label: 'Data'),
      ],
    );
  }
}
