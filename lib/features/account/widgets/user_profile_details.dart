import 'package:app_ui/app_ui.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AppCubit cubit) => cubit.state.user ?? AppUser.anonymous,
    );
    return Column(
      children: [
        UserAvatar(),
        Gap.v(AppSpacing.md),
        Row(
          spacing: AppSpacing.md,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.fullName,
              style: poppinsTextStyle(
                fontWeight: AppFontWeight.bold,
                fontSize: AppSpacing.lg,
              ),
            ),
            if (user.isVerified && user.isKycVerified)
              Assets.icons.verify.svg(),
          ],
        ),
        Gap.v(AppSpacing.sm),
        Text.rich(
          style: poppinsTextStyle(fontSize: AppSpacing.md),
          TextSpan(
            text: '${user.email}   ',
            children: [
              TextSpan(text: '|    '),
              TextSpan(text: user.phone),
            ],
          ),
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment(0, 0),
      decoration: BoxDecoration(
        color: AppColors.brightGrey,
        shape: BoxShape.circle,
        image: DecorationImage(image: Assets.images.avatar.provider()),
      ),
    );
  }
}
