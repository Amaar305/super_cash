import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_repository/token_repository.dart';

import '../../../auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
    final hasBiometric =
        serviceLocator<TokenRepository>().getBiometric() ?? false;
    context.read<LoginCubit>().resetState(hasBiometric: hasBiometric);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final hasBiometric =
        serviceLocator<TokenRepository>().getBiometric() ?? false;
    context.read<LoginCubit>().resetState(hasBiometric: hasBiometric);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xxlg,
      children: [LoginEmailField(), LoginPasswordField()],
    );
  }
}
