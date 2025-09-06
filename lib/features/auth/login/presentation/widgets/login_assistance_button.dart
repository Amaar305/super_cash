import 'package:super_cash/features/auth/login/presentation/presentation.dart';
import 'package:super_cash/features/auth/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAssistanceButton extends StatelessWidget {
  const LoginAssistanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (LoginCubit element) => element.state.status.isLoading,
    );
    return AssistanceButton(isLoading: isLoading);
  }
}
