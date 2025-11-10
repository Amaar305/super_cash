import 'package:firebase_core/firebase_core.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/services/notification_service.dart';
import 'package:super_cash/firebase_options.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependencies
  await initDependencies();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Notification setups
  NotificationService().initialize();

  // Hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(App(user: AppUser.anonymous));
}
