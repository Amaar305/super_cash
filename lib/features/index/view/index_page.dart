import 'package:app_ui/app_ui.dart';
import 'package:flutter/services.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/history/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../home/home.dart';
import '../../navigation/navigation.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            appCubit: context.read<AppCubit>(),
            fetchAppSettingsUseCase: serviceLocator(),
            fetchUserUseCase: serviceLocator(),
          )..onRefresh(forceRefresh: true),
        ),
        BlocProvider(
          create: (context) =>
              HistoryCubit(fetchTransactionsUseCase: serviceLocator())
                ..fetchInitialTransactions(),
        ),
      ],
      child: IndexView(navigationShell: navigationShell),
    );
  }
}

class IndexView extends StatefulWidget {
  const IndexView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await onWillPop(context);
      },
      child: AppScaffold(
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavBar(
          navigationShell: widget.navigationShell,
        ),
      ),
    );
  }

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );

      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
