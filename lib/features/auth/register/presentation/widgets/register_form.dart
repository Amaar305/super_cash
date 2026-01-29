import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';

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
          final user = state.user;
          final sanitizedFullName = user.fullName.trim().isNotEmpty
              ? user.fullName.trim()
              : '${user.firstName} ${user.lastName}'.trim();
          final displayName = sanitizedFullName.isNotEmpty
              ? sanitizedFullName
              : 'there';
          final message = state.errorMessage;
          context.showConfirmationBottomSheet(
            title: 'Congratulations, $displayName!',
            okText: AppStrings.proceed,
            description: message.isNotEmpty
                ? message
                : 'Your account has been created successfully. Tap below to continue.',
            descriptionColor: message.isNotEmpty ? AppColors.orange : null,
            onDone: () {
              context.pop();
              context.read<AppCubit>().referralType();
            },
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
