import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/common/widgets/validation_summary_container.dart';

class ValidationSummaryCard extends StatelessWidget {
  const ValidationSummaryCard({
    super.key,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  });

  final String bankName;
  final String accountName;
  final String accountNumber;

  @override
  Widget build(BuildContext context) {
    return ValidationSummaryContainer(
      child: Column(
        spacing: AppSpacing.xs,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValidationDetailRow(title: 'Bank', value: bankName),
          const AppDivider(),
          ValidationDetailRow(
            title: 'Account Name',
            value: accountName,
            color: AppColors.green,
          ),
          const AppDivider(),
          ValidationDetailRow(title: 'Account Number', value: accountNumber),
        ],
      ),
    );
  }
}
