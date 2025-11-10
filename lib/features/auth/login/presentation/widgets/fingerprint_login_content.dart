import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/core/helper/fingerprint_authentication.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/bloc/app_bloc.dart';

class FingerprintLoginContent extends StatelessWidget {
  const FingerprintLoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        Container(
          // padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5),
          ),
          child: FittedBox(
            child: Assets.images.logo.image(width: 100, fit: BoxFit.cover),
          ),
        ),
        Gap.v(AppSpacing.xlg),
        Column(
          children: [
            Text(
              'Welcome Back!',
              style: context.titleLarge?.copyWith(fontSize: 28),
            ),
            const LoggedInWelcomeBackName(),
            LoggedInMaskedUserEmailText(),
          ],
        ),
        Gap.v(AppSpacing.xxlg * 2),
        FingerprintContainer(),
      ],
    );
  }
}

class FingerprintContainer extends StatelessWidget {
  const FingerprintContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: Column(
            spacing: AppSpacing.xlg,
            children: [
              Text(
                'Login with fingerprint or face ID',
                style: context.bodySmall,
              ),
              FingerprintIconButton(),
              FingerprintButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class FingerprintIconButton extends StatelessWidget {
  const FingerprintIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    void unAuthenticated() {
      context.read<LoginCubit>().onLoginWithBiometric(
        onSuccess: (user) {
          // _appBloc.add(UserLoggedIn(token));

          context.read<AppBloc>().add(UserLoggedIn(user));
        },
      );
    }

    return Tappable.faded(
      throttle: true,
      throttleDuration: const Duration(milliseconds: 500),
      onTap: () async {
        await fingerprintAuthentication(onAuthenticated: unAuthenticated);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary2,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.fingerprint, size: 54, color: AppColors.white),
      ),
    );
  }
}

class FingerprintButton extends StatelessWidget {
  const FingerprintButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onAuthenticated() {
      final loginCubit = context.read<LoginCubit>();
      loginCubit.onLoginWithBiometric(
        onSuccess: (user) {
          context.read<AppBloc>().add(UserLoggedIn(user));

          if (!user.transactionPin) {
            Navigator.pushAndRemoveUntil(
              context,
              CreatePinPage.route(),
              (_) => true,
            );
            return;
          }

          if (!user.isVerified) {
            Navigator.pushAndRemoveUntil(
              context,
              VerifyPage.route(email: user.email),
              (_) => true,
            );
            return;
          }
        },
      );
    }

    return PrimaryButton(
      label: AppStrings.proceed,
      onPressed: () async {
        await fingerprintAuthentication(
          onAuthenticated: onAuthenticated,
          onUnAuthenticated: (s) {
            context.read<LoginCubit>().onBiometricFailure(s);
          },
        );
      },
    );
  }
}

class LoggedInMaskedUserEmailText extends StatelessWidget {
  const LoggedInMaskedUserEmailText({super.key});

  @override
  Widget build(BuildContext context) {
    final user = serviceLocator<LoginLocalDataSource>().getUser();

    return Text(
      maskEmail(user?.email ?? 'useremail'),
      style: poppinsTextStyle(fontWeight: FontWeight.w400, fontSize: 13),
    );
  }
}

class LoggedInWelcomeBackName extends StatelessWidget {
  const LoggedInWelcomeBackName({super.key});

  @override
  Widget build(BuildContext context) {
    final user = serviceLocator<LoginLocalDataSource>().getUser();

    return PurchaseContainerInfo(
      useWidth: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          user?.fullName ?? 'name',
          style: poppinsTextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
