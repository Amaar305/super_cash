import 'package:animations/animations.dart';
import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/features/auth/login/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormSwitcher extends StatelessWidget {
  const LoginFormSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isPasswordLogin = context.select(
      (LoginCubit cubit) => cubit.state.isPasswordLogin,
    );

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
         if (state.status.isLoading) {
          showLoadingOverlay(context);
        } else {
          hideLoadingOverlay();
        }
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }
        if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(title: 'Login successful!'),
            clearIfQueue: true,
          );
          return;
        }
      },
      child: PageTransitionSwitcher(
        reverse: isPasswordLogin,
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            fillColor: AppColors.transparent,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: isPasswordLogin
            ? const LoginWithPassword(key: ValueKey('passwordLogin'))
            : LoginWithFingerprint(key: const ValueKey('fingerprintLogin')),
      ),
    );
  }
}
