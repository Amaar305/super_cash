import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class TransferToBankForm extends StatelessWidget {
  const TransferToBankForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: AppSpacing.lg,
      children: [
        BonusAccountNumberField(),
        BonusBankListDropdown(),
        TransferToBankValidatedFields(),
      ],
    );
  }
}

class TransferToBankValidatedFields extends StatelessWidget {
  const TransferToBankValidatedFields({super.key});

  @override
  Widget build(BuildContext context) {
    final isValidated = context.select(
      (BonusCubit element) => element.state.status.isValidated || element.state.bankValidationResult!=null,
    );

    return AnimatedSwitcher(
      duration: 200.ms,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: isValidated
          ? Column(
              spacing: AppSpacing.lg,
              children: [ValidatedDetailWidget(), BonusAmountField()],
            )
          : SizedBox.shrink(),
    );
  }
}

class ValidatedDetailWidget extends StatelessWidget {
  const ValidatedDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bankResult = context.select(
      (BonusCubit element) => element.state.bankValidationResult,
    );
    final bankName = context.select(
      (BonusCubit element) => element.state.selectedBank?.bankName,
    );
    if (bankResult == null || bankName == null) return SizedBox.shrink();

    return ValidationSummaryCard(
      bankName: bankName,
      accountName: bankResult.accountName,
      accountNumber: bankResult.accountNumber,
    );
  }
}
