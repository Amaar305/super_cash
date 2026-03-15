import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayWinnerCard extends StatelessWidget {
  const GiveawayWinnerCard({super.key, required this.winner});
  final GiveawayWinner winner;

  @override
  Widget build(BuildContext context) {
    final color = winner.type.code == 'airtime-pin'
        ? AppColors.blue
        : AppColors.green;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.xlg),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.3),
          radius: 25,
          child: Text(hh(winner.winner)),
        ),
        title: Text(
          winner.winner,
          style: poppinsTextStyle(
            fontSize: 14,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),

        subtitle: Row(
          spacing: AppSpacing.md,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              dateAgo(winner.createdAt),
              style: poppinsTextStyle(fontSize: 12, color: AppColors.grey),
            ),
            Icon(Icons.circle, size: 8, color: AppColors.grey),
            Container(
              padding: EdgeInsets.all(8),
              // margin: EdgeInsets.only(top: AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSpacing.xlg),
              ),
              child: Text(
                winner.type.name.replaceAll("PIN", "").toUpperCase(),
                style: poppinsTextStyle(
                  fontSize: 11,
                  fontWeight: AppFontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        trailing: Text(
          "N${winner.amount}",
          style: poppinsTextStyle(fontWeight: AppFontWeight.black),
        ),
      ),
    );
  }

  String hh(String winner) {
    final sp = winner.split(' ');
    final a1 = sp.first[0];
    final a2 = sp.last[0];
    return '$a1$a2'.toUpperCase();
  }
}
