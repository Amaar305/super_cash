import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }
      },
      child: WalletContainer(
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSpacing.sm,
            children: [
              HomeHeader(),
              Gap.v(AppSpacing.xlg),
              Text(
                AppStrings.availableBalance,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: AppFontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Balance(),
              Bonus(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.sm,
                children: [
                  Text(
                    AppStrings.accountNumber,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '0070600723',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'Moniepoint Bank',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Tappable.scaled(
                    onTap: () {},
                    child: SizedBox.square(
                      dimension: 18,
                      child: Assets.icons.copy.svg(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletContainer extends StatelessWidget {
  const WalletContainer({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.3,
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spaceUnit),
      decoration: BoxDecoration(
        color: AppColors.primary2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.sm),
          bottomRight: Radius.circular(AppSpacing.sm),
        ),
        // image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: Assets.images.bg5.provider(),
        // ),
        // gradient: LinearGradient(
        //   colors: [
        //     AppColors.red,
        //     AppColors.red,
        //     AppColors.red,
        //     // AppColors.transparent,
        //   ],
        //   // stops: [0.15, 1.0],
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        //   // tileMode: TileMode.decal,
        // ),
      ),
      child: child,
    );
  }
}
