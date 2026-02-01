import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeLowWalletAlert extends StatelessWidget {
  const HomeLowWalletAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = context.select(
      (AppCubit cubit) =>
          double.tryParse(cubit.state.user?.wallet.walletBalance ?? "0.0") ?? 0,
    );

    if (balance >= 100) {
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      // height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFfff5f5), const Color(0xFFFFEAEA)],
        ),

        borderRadius: BorderRadius.circular(AppSpacing.md + 2),
        border: Border(
          left: BorderSide(color: AppColors.warning, width: 5),
          right: newMethod(),
          top: newMethod(),
          bottom: newMethod(),
        ),

        // border: Border,
      ),
      child: Row(
        children: [
          // Icon
          _IconContainer(),
          Gap.h(AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxs,
              children: [
                Text(
                  'Low balance N$balance',
                  style: poppinsTextStyle(
                    fontSize: 16,
                    fontWeight: AppFontWeight.black,
                    color: const Color.fromARGB(255, 247, 19, 2),
                  ),
                ),
                Text(
                  'Fund your wallet today to enjoy our services and to be eligible for our cash earning prrogrammes.',
                  style: poppinsTextStyle(
                    fontSize: 10,
                    fontWeight: AppFontWeight.light,
                  ),
                ),
              ],
            ),
          ),

          // Fund Button
          NewWidget(),
        ],
      ),
    );
  }

  BorderSide newMethod() => BorderSide(color: AppColors.warning, width: 1.5);
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      autoPlay: true,
      onComplete: (controller) => controller.repeat(),
      effects: const [
        // RotateEffect(

        // ),
        ShimmerEffect(
          delay: Duration(milliseconds: 100),
          curve: Curves.linear,
          duration: Duration(seconds: 1),
        ),
      ],
      child: Material(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(AppSpacing.md),

        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          // onTap: () => _navigate(context),
          onTap: () {
            context.goNamedSafe(RNames.addFunds);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              spacing: AppSpacing.xxs,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wallet, color: AppColors.white, size: 23),
                Text(
                  'Fund',
                  style: poppinsTextStyle(
                    fontSize: 12,
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconContainer extends StatefulWidget {
  const _IconContainer();

  @override
  State<_IconContainer> createState() => _IconContainerState();
}

class _IconContainerState extends State<_IconContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.15).animate(_scale),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.warning,
          borderRadius: BorderRadius.circular(AppSpacing.xxxlg),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.2)),
        ),
        child: Icon(Icons.warning, color: AppColors.white, size: 25),
      ),
    );
  }
}
