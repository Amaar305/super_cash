import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_strings/app_string.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final navigationBarItems = mainNavigationBarItems(
      homeLabel: AppStrings.homeNavBarItemLabel,
      historyLabel: AppStrings.history,
      liveChatLabel: AppStrings.liveChatNavBarItemLabel,
      userProfileLabel: AppStrings.profileNavBarItemLabel,
    );
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      iconSize: 24,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: navigationBarItems
          .map(
            (e) => BottomNavigationBarItem(
              icon: e.child ?? Icon(e.icon),
              tooltip: e.tooltip,
              label: e.label,
              activeIcon: e.activeChild,
            ),
          )
          .toList(),
    );
  }
}


  // bool pushed = false;
  // bool paused = false;
  // late DateTime pausedTime;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   pausedTime = DateTime.now();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);

  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       var duration = DateTime.now().difference(pausedTime);
  //       if (!pushed && paused && duration.inMinutes >= 2) {
  //         pushed = true;
  //         context.read<AppBloc>().add(AppStarted());
  //         pushed = false;
  //         paused = false;
  //       }
  //       break;
  //     case AppLifecycleState.paused:
  //       paused = true;
  //       pausedTime = DateTime.now();
  //     default:
  //   }}