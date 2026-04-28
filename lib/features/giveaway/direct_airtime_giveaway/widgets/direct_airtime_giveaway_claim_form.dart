import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';


class DirectAirtimeGiveawayClaimForm extends StatelessWidget {
  const DirectAirtimeGiveawayClaimForm({super.key, required this.network});
  final String network;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [DirectAirtimeGiveawayClaimPhoneField(network: network)],
    );
  }
}
