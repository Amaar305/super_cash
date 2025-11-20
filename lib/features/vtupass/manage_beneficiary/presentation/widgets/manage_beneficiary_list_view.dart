import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';

class ManageBeneficiaryListView extends StatelessWidget {
  const ManageBeneficiaryListView({
    super.key,
    required this.beneficiaries,
    required this.hasReachMax,
    this.fromBeneficiary = false,
  });

  final List<Beneficiary> beneficiaries;
  final bool hasReachMax;
  final bool fromBeneficiary;

  @override
  Widget build(BuildContext context) {
    if (beneficiaries.isEmpty) {
      return const AppEmptyState(
        title: 'No beneficiaries yet',
        description:
            'Save frequently used accounts here to make future transfers faster.',
        icon: Icons.groups_2_outlined,
      );
    }
    return ListView.separated(
      itemCount: beneficiaries.length,
      itemBuilder: (context, index) {
        final beneficiary = beneficiaries[index];
        return ManageBeneficiaryTile(
          beneficiary: beneficiary,
          fromBeneficiary: fromBeneficiary,
        );
      },
      separatorBuilder: (context, index) => Gap.v(AppSpacing.sm),
    );
  }
}
