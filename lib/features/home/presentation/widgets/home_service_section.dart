import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';

class HomeServicesSection extends StatelessWidget {
  const HomeServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      HomeServiceActionButton(
        'Cable sub',
        icon: Assets.icons.cable.svg(),
        onTap: () => context.push(AppRoutes.cable),
      ),
      HomeServiceActionButton(
        'Buy Airtime',
        icon: Assets.icons.airttime.svg(),
        onTap: () => context.push(AppRoutes.airtime),
      ),
      HomeServiceActionButton(
        'Buy Data',
        icon: Assets.icons.data.svg(),
        onTap: () => context.push(AppRoutes.data),
      ),
      HomeServiceActionButton(
        'Electricity',
        icon: Assets.icons.electricity.svg(),
        onTap: () => context.push(AppRoutes.electricity),
      ),
      HomeServiceActionButton(
        'Beneficiary',
        icon: Icon(
          Icons.people_alt_outlined,
          size: 24,
          color: AppColors.darkGrey,
        ),
        onTap: () => context.push(AppRoutes.manageBeneficiary),
      ),
      HomeServiceActionButton(
        'Refer',
        icon: Assets.icons.refer.svg(),
        onTap: () => context.push(AppRoutes.referFriend),
      ),
      HomeServiceActionButton(
        'Exam Pin',
        icon: Assets.icons.exam.svg(),
        onTap: () => context.push(AppRoutes.examPin),
      ),
      HomeServiceActionButton(
        'Smile Voice',
        icon: Assets.icons.smile.svg(),
        onTap: () => context.push(AppRoutes.smile),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(fontWeight: AppFontWeight.semiBold),
          ),
          Gap.v(AppSpacing.spaceUnit),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: services.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => services[index],
          ),
        ],
      ),
    );
  }
}

class HomeServiceActionButton extends StatelessWidget {
  const HomeServiceActionButton(
    this.text, {
    super.key,
    required this.icon,
    this.onTap,
  });
  final String text;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.scaled(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        children: [
          SizedBox.square(dimension: 24, child: icon),
          Text(
            text,
            textAlign: TextAlign.center,
            style: poppinsTextStyle(
              fontSize: 11,
              fontWeight: AppFontWeight.regular,
            ),
          ),
        ],
      ),
    );
  }
}
