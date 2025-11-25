import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../app/app.dart';
import '../../../auth.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final Debouncer _debouncer;
  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
    context.read<ForgotPasswordCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ForgotPasswordCubit>().resetState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
        if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(
              title: 'OTP has been sent successfully',
            ),
            clearIfQueue: true,
          );
        }
      },
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        // buildWhen: (p, c) => p.status != c.status,
        builder: (context, state) {
          return Column(
            children: [
              if (state.withEmail)
                ForgotPasswordEmailField(key: ValueKey('email_f'))
              else
                ForgotPasswordPhoneField(key: ValueKey('phone_f')),
            ],
          );
        },
      ),
    );
  }
}
