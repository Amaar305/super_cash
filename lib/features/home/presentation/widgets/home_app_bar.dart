import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/home/home.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      elevation: 1,
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          height: 78,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 16,
              bottom: 8,
              left: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    HomeWelcomeText(),
                    Spacer(),
                    HomeNotificationBadge(),
                    Gap.h(AppSpacing.md),
                    Tappable.faded(
                      onTap: () => _showSideMenu(context),
                      child: SizedBox.square(
                        dimension: 24,
                        child: Assets.icons.menu.svg(
                          colorFilter: ColorFilter.mode(
                            AppColors.background,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Gap.v(AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showSideMenu(BuildContext context) {
  final rootContext = context;
  final menuActions = [
    _MenuAction(
      label: 'Buy Airtime',
      icon: Assets.icons.airttime.svg(),
      onTap: () => rootContext.goNamedSafe(RNames.airtime),
    ),
    _MenuAction(
      label: 'Buy Data',
      icon: Assets.icons.data.svg(),
      onTap: () => rootContext.goNamedSafe(RNames.data),
    ),
    _MenuAction(
      label: 'Buy Electricity',
      icon: Assets.icons.electricity.svg(),
      onTap: () => rootContext.goNamedSafe(RNames.electricity),
    ),
    _MenuAction(
      label: 'Buy Cable',
      icon: Assets.icons.cable.svg(),
      onTap: () => rootContext.goNamedSafe(RNames.cable),
    ),
  ];

  showGeneralDialog<void>(
    context: context,
    barrierLabel: 'Side menu',
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.centerRight,
        child: FractionallySizedBox(
          widthFactor: 0.82,
          child: SafeArea(
            child: _SideMenu(
              actions: menuActions,
              onClose: () => Navigator.of(dialogContext).pop(),
              onLogout: () {
                Navigator.of(dialogContext).pop();
                dialogContext.read<AppCubit>().logout();
              },
            ),
          ),
        ),
      );
    },
    transitionBuilder: (dialogContext, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: FadeTransition(opacity: curvedAnimation, child: child),
      );
    },
  );
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({
    required this.actions,
    required this.onLogout,
    required this.onClose,
  });

  final List<_MenuAction> actions;
  final VoidCallback onLogout;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            bottomLeft: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(-10, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueFilled,
                    shape: BoxShape.circle,
                  ),
                  child: Assets.icons.menu.svg(
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      AppColors.darkGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Gap.h(AppSpacing.md),
                Text(
                  'Quick access',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onClose,
                  splashRadius: 22,
                  icon: Icon(Icons.close_rounded, color: AppColors.darkGrey),
                ),
              ],
            ),
            Gap.v(AppSpacing.md),
            ...actions.map(
              (action) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _MenuTile(
                  action: action,
                  onTap: () {
                    onClose();
                    action.onTap();
                  },
                ),
              ),
            ),
            const Spacer(),
            Divider(color: AppColors.brightGrey.withValues(alpha: 0.6)),
            Gap.v(AppSpacing.sm),
            _MenuTile(
              action: _MenuAction(
                label: 'Logout',
                icon: Icon(
                  Icons.logout_rounded,
                  color: AppColors.red,
                  size: 22,
                ),
                onTap: onLogout,
              ),
              onTap: onLogout,
              accentColor: AppColors.red.shade50,
              textColor: AppColors.red.shade700,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.action,
    required this.onTap,
    this.accentColor,
    this.textColor,
  });

  final _MenuAction action;
  final VoidCallback onTap;
  final Color? accentColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: accentColor ?? AppColors.lightBlueFilled,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: (accentColor ?? AppColors.lightBlueFilled).withValues(
              alpha: 0.8,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox.square(dimension: 18, child: action.icon),
            Gap.h(AppSpacing.md),
            Text(
              action.label,
              style: poppinsTextStyle(
                // fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor ?? AppColors.darkGrey,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: textColor ?? AppColors.emphasizeGrey,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuAction {
  const _MenuAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;
}
