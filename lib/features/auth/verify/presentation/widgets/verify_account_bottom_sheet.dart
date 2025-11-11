import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class VerifyAccountBottomSheet extends StatelessWidget {
  const VerifyAccountBottomSheet({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.34,
      child: AppConstrainedScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceUnit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSpacing.md,
            children: [
              // Gap.v(AppSpacing.spaceUnit),
              Assets.images.circleCheck.image(width: 77, height: 77),
              Text(AppStrings.succesTile, style: context.titleMedium),
              Text(
                AppStrings.emailVerificationSuccess,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFontWeight.extraLight,
                ),
              ),
              Gap.v(AppSpacing.spaceUnit / 2),
              PrimaryButton(
                isLoading: false,
                label: 'Done',
                onPressed: () {
                  Navigator.pop(context); // Close bottom sheet
                  context.read<AppCubit>().userLoggedIn(user);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
