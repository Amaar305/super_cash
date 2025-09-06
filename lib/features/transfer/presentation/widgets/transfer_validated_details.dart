import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class TransferValidatedDetails extends StatelessWidget {
  const TransferValidatedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bankDetail = context.select(
      (TransferCubit cubit) => cubit.state.bankDetail,
    );
    return PurchaseContainerInfo(
      child: Column(
        spacing: AppSpacing.md,
        children: [
          _detailTile('Bank Name: ', bankDetail?.bankName ?? ''),
          _detailTile('Account Number: ', bankDetail?.accountNumber ?? ''),
          _detailTile('Account Name: ', bankDetail?.accountName ?? ''),
          Text(
            AppStrings.transferInstruction,
            style: TextStyle(fontSize: AppSpacing.md, color: AppColors.red),
          ),
        ],
      ),
    );
  }

  Text _detailTile(String text, String text2) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: text,
        style: TextStyle(
          color: AppColors.blue,
          fontWeight: AppFontWeight.medium,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              color: AppColors.background3,
              fontWeight: AppFontWeight.regular,
            ),
          ),
        ],
      ),
    );
  }
}
