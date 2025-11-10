import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginUseCase: serviceLocator(),
        biometricUseCase: serviceLocator(),
        determineLoginFlowUseCase: serviceLocator(),
        appBloc: context.read<AppBloc>(),
        hasBiometric: false,
      ),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    // Call when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginCubit>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: _appBar(context),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSpacing.xlg,
            children: [const LoginTypeTabs(), LoginFormSwitcher()],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: AppLeadingAppBarWidget(onTap: () {}),
      title: const AppAppBarTitle(AppStrings.login),
    );
  }
}
