import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../auth.dart';

class LoginWithPassword extends StatelessWidget {
  const LoginWithPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginContent(),
        MyWidget(),
        LoginButton(),
        // DontHaveAccountButton(),
        Gap.v(AppSpacing.xlg),
        AuthSocialContainer(),
        // LoginAssistanceButton(),
      ],
    );
  }
}
