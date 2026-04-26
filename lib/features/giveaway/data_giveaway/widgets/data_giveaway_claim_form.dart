import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/giveaway/data_giveaway/widgets/data_giveaway_claim_phone_field.dart';

class DataGiveawayClaimForm extends StatelessWidget {
  const DataGiveawayClaimForm({super.key, required this.network});
  final String network;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [DataGiveawayClaimPhoneField(network: network)],
    );
  }
}
