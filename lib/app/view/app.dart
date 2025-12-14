import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
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
        BlocProvider.value(value: serviceLocator<AppBloc>()),
        BlocProvider.value(value: serviceLocator<AppCubit>()),
        BlocProvider.value(value: serviceLocator<CooldownCubit>()),

        BlocProvider.value(value: serviceLocator<ConfirmTransactionPinCubit>()),

        BlocProvider.value(value: serviceLocator<CardRepoCubit>()),
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

AppLoadingOverlayController? _loadingOverlayController;

void showLoadingOverlay(
  BuildContext context, {
  String? title,
  String? message,
}) {
  if (_loadingOverlayController?.isShowing ?? false) return;

  final colorScheme = Theme.of(context).colorScheme;

  _loadingOverlayController = showAppLoadingOverlay(
    context,
    title: title ?? 'Hang tight...',
    message: message ?? 'We are syncing your experience.',
    primary: colorScheme.primary,
    secondary: colorScheme.secondary,
  );
}

void hideLoadingOverlay() {
  final controller = _loadingOverlayController;
  if (controller == null) return;

  controller.close();
  _loadingOverlayController = null;
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
