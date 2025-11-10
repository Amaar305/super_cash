import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/app.dart';
import '../presentation.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<RegisterCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.errorMessage),
            clearIfQueue: true,
          );
        }
        if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(
              title: 'Registration successful! Please verify your email.',
            ),
            clearIfQueue: true,
          );
        }
      },
      listenWhen: (p, c) => p.status != c.status,
      child: _RegisterForm(),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();
  @override
  Widget build(BuildContext context) {
    final basicSignup = context.select(
      (RegisterCubit element) => element.state.basicSignup,
    );

    // return basicSignup
    //     ? RegisterWithBasicSignup(
    //         // key: ValueKey('form_r'),
    //         )
    //     : RegisterWithGoogle(
    //         // key: ValueKey('google_r'),
    //         );

    return basicSignup ? RegisterWithBasicSignup() : RegisterWithGoogle();
  }
}
