import 'package:app_ui/app_ui.dart';
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

class IndexView extends StatelessWidget {
  const IndexView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
    );
  }
}
