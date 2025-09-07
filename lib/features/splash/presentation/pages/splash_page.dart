import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/onboarding/onboarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _fired = false;

  @override
  void initState() {
    super.initState();
    // When we arrive here and onboarding == true, kick the bloc to resolve auth/home.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_fired || !mounted) return;
      final launch = serviceLocator<LaunchState>();
      if (launch.onboarded == true) {
        _fired = true;
        context.read<AppBloc>().add(AppStarted());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.xlg,
          children: [
            Text(
              AppStrings.appName,
              textAlign: TextAlign.center,
              style: context.titleLarge,
            ),
            SizedBox.square(
              dimension: AppSpacing.lg,
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
