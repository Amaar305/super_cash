import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
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
      return Center(
        child: Text(
          'No beneficiaries found',
          style: poppinsTextStyle(
            color: AppColors.grey,
            fontSize: 14,
            fontWeight: AppFontWeight.regular,
          ),
        ),
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
