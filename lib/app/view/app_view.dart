import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final routerConfig = AppRouter(
    serviceLocator<AppBloc>(),
    serviceLocator<AppCubit>(),
  ).router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: const AppTheme().theme,
      darkTheme: const AppDarkTheme().theme,
      themeMode: ThemeMode.light,
      routerConfig: routerConfig,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            AppSnackbar(key: snackbarKey),
            AppLoadingIndeterminate(key: loadingIndeterminateKey),
          ],
        );
      },
    );
  }
}
