import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/services/notification_service.dart';
import 'package:super_cash/firebase_options.dart';
import 'package:token_repository/token_repository.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependencies
  await initDependencies();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  unawaited(_setupNotificationsWhenAuthenticated());

  // Hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App(user: AppUser.anonymous));
}

Future<void> _setupNotificationsWhenAuthenticated() async {
  final notificationService = NotificationService();
  final tokenRepository = serviceLocator<TokenRepository>();
  final appCubit = serviceLocator<AppCubit>();

  Future<void> init() async {
    try {
      await notificationService.initialize();
    } catch (error, stackTrace) {
      logE(
        'Failed to initialize notifications: $error',
        stackTrace: stackTrace,
      );
    }
  }

  if (await tokenRepository.hasToken()) {
    await init();
    return;
  }

  await appCubit.stream.firstWhere(
    (state) => state.status == AppStatus2.authenticated,
  );
  await init();
}
