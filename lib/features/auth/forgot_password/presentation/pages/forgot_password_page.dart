import 'package:animations/animations.dart';
import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageForgotPasswordPage extends StatelessWidget {
  const ManageForgotPasswordPage({super.key});

  static Route<void> route() => PageRouteBuilder(
    pageBuilder: (_, __, ___) => const ManageForgotPasswordPage(),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ManagePasswordCubit()),
        BlocProvider(
          create: (context) =>
              ForgotPasswordCubit(requestOtpWithEmailUseCase: serviceLocator()),
        ),
        BlocProvider(
          create: (context) =>
              ChangePasswordCubit(changePasswordUseCase: serviceLocator()),
        ),
      ],
      child: ForgotPasswordPage(),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final showForgotPassword = context.select(
      (ManagePasswordCubit b) => b.state,
    );

    return PageTransitionSwitcher(
      reverse: showForgotPassword,
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      child: showForgotPassword
          ? const ForgotPasswordView()
          : ChangePasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.md,
            children: [
              Gap.v(AppSpacing.spaceUnit),
              ForgotPasswordType(),
              const ForgotPasswordForm(),
              Gap.v(AppSpacing.spaceUnit),
              const Align(child: ForgotButtonSendEmailButton()),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: AppLeadingAppBarWidget(onTap: () => context.pop()),
    title: Text(
      AppStrings.forgotPassword,
      style: TextStyle(fontWeight: AppFontWeight.semiBold, fontSize: 16),
    ),
  );
}
