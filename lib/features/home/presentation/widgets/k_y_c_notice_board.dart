import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KYCNoticeBoard extends StatelessWidget {
  const KYCNoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final isKYCVerified = context.select(
      (AppBloc cubit) => cubit.state.user.isKycVerified,
    );

    if (isKYCVerified) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: Material(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        color: AppColors.green.withValues(alpha: 0.1),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.sm),
          height: 120,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.sm,
            children: [
              Text(
                'KYC Not Verified',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: poppinsTextStyle(
                  fontSize: 14,
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.red,
                ),
              ),
              Text(
                'Please verify your KYC to enjoy all features',
                textAlign: TextAlign.center,
                maxLines: 2,
                //
                // This is a long text that should be truncated if it exceeds the available space.
                // It should not overflow and should be displayed properly.
                // The text should be styled with a specific font size and weight.
                // The color should be green to indicate a positive message.
                // The text should be centered and should not exceed two lines.
                // It should be styled with a specific font size and weight.
                // The color should be green to indicate a positive message.
                overflow: TextOverflow.ellipsis,
                style: poppinsTextStyle(
                  fontSize: 12,
                  fontWeight: AppFontWeight.regular,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
