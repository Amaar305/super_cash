import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/models/account.dart';

class BankDetailCard extends StatelessWidget {
  const BankDetailCard({super.key, required this.bankDetail, this.label});
  final Account bankDetail;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Color.fromRGBO(235, 248, 255, 1),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppSpacing.md,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.medium,
                      fontSize: 10,
                    ),
                  ),
                Tappable.scaled(
                  throttle: true,
                  onTap: () {
                    copyAccountNumber(context, bankDetail.accountNumber);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Account number copied to clipboard'),
                      ),
                    );
                  },
                  child: Icon(Icons.copy_outlined, size: AppSpacing.lg - 1),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs + 2,
              children: [
                _detailTile('Bank Name: ', bankDetail.bankName),
                _detailTile('Account Number: ', bankDetail.accountNumber),
                _detailTile('Account Name: ', bankDetail.accountName),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _detailTile(String text, String text2) {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: text,
        style: poppinsTextStyle(
          color: AppColors.deepBlue,
          fontWeight: AppFontWeight.medium,
          fontSize: 10,
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

class BankDetail {
  final String bankName;
  final String accountName;
  final String accountNumber;

  const BankDetail({
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  });
}
