import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/cooldown/cubit/cooldown_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../features/card/card_repo/cubit/card_repo_cubit.dart';
import '../../features/confirm_transaction_pin/presentation/cubit/confirm_transaction_pin_cubit.dart';
import '../app.dart';
import '../bloc/app_bloc.dart';

/// Key to access the [AppSnackbarState] from the [BuildContext].
final snackbarKey = GlobalKey<AppSnackbarState>();

/// Key to access the [AppLoadingIndeterminateState] from the
/// [BuildContext].
final loadingIndeterminateKey = GlobalKey<AppLoadingIndeterminateState>();

class App extends StatelessWidget {
  const App({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    // final launch = serviceLocator<LaunchState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AppBloc>()),
        BlocProvider(create: (context) => serviceLocator<CooldownCubit>()),
        BlocProvider(
          create: (context) => serviceLocator<ConfirmTransactionPinCubit>(),
        ),
        BlocProvider(create: (context) => serviceLocator<CardRepoCubit>()),
      ],
      child: AppView(),
    );
  }
}

/// Snack bar to show messages to the user.
void openSnackbar(
  SnackbarMessage message, {
  bool clearIfQueue = false,
  bool undismissable = false,
}) {
  snackbarKey.currentState?.post(
    message,
    clearIfQueue: clearIfQueue,
    undismissable: undismissable,
  );
}

void toggleLoadingIndeterminate({bool enable = true, bool autoHide = false}) =>
    loadingIndeterminateKey.currentState?.setVisibility(
      visible: enable,
      autoHide: autoHide,
    );

/// Closes all snack bars.
void closeSnackbars() => snackbarKey.currentState?.closeAll();

void showCurrentlyUnavailableFeature({bool clearIfQueue = true}) =>
    openSnackbar(
      const SnackbarMessage.error(
        title: 'Feature is not available!',
        description:
            'We are trying our best to implement it as fast as possible.',
        icon: Icons.error_outline,
      ),
      clearIfQueue: clearIfQueue,
    );
