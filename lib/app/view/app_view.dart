import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/bloc/app_bloc.dart' hide AppState;
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
  bool _tokenDialogVisible = false;

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
        return BlocListener<AppCubit, AppState>(
          listenWhen: (previous, current) =>
              current.status == AppStatus2.tokenExpired,
          listener: (context, state) async {
            final navigatorContext =
                routerConfig.routerDelegate.navigatorKey.currentContext;
            if (!mounted || _tokenDialogVisible || navigatorContext == null) {
              return;
            }
            _tokenDialogVisible = true;
            try {
              await showDialog<void>(
                context: navigatorContext,
                barrierDismissible: false,
                // ignore: deprecated_member_use
                builder: (_) => WillPopScope(
                  onWillPop: () async => false,
                  child: NewWidget(),
                ),
              );
            } finally {
              _tokenDialogVisible = false;
            }
          },
          child: Stack(
            children: [
              child!,
              AppSnackbar(key: snackbarKey),
            ],
          ),
        );
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AlertDialog.adaptive(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      backgroundColor: colorScheme.surface,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Session Expired',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        'For your security we signed you out. Please login again to continue.',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              serviceLocator<AppCubit>().logout();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Login Again'),
          ),
        ),
      ],
    );
  }
}
