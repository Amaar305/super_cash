import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/onboarding/launch_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 211,
              height: 167,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.logo.provider(),
                  fit: BoxFit.cover,
                ),
                color: AppColors.brightGrey,
                borderRadius: BorderRadius.circular(18),
              ),
            ),

            Gap.v(AppSpacing.lg),
            Text(
              AppStrings.appName,
              style: poppinsTextStyle(
                fontSize: AppSpacing.xlg,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            Gap.v(AppSpacing.sm),
            Text(
              'Welcome to ${AppStrings.appName} App.\nEnjoy seamless features, fast transactions and cash earning programs at a very user friendly cost.',
              textAlign: TextAlign.center,
              style: poppinsTextStyle(fontWeight: AppFontWeight.light),
            ),
            Gap.v(AppSpacing.xxlg),

            PrimaryButton(
              label: 'Create an Account',
              onPressed: () {
                // Mark welcome done
                serviceLocator<LaunchState>().completeWelcome(false);

                // Ensure auth state is resolved; router will redirect to /auth or /dashboard
                context.read<AppBloc>().add(AppStarted());
              },
            ),
            Gap.v(AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: AppButton.outlined(
                text: 'Login',
                onPressed: () {
                  // Mark welcome done
                  serviceLocator<LaunchState>().completeWelcome(true);

                  // Ensure auth state is resolved; router will redirect to /auth or /dashboard
                  context.read<AppBloc>().add(AppStarted());
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
