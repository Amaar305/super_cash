import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';

class RegisterWithBasicSignup extends StatelessWidget {
  const RegisterWithBasicSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xlg,
        children: [
          // First name
          FirstNameField(),

          // Last name
          LastNameField(),

          // Email Address
          EmailField(),

          // Phone number
          PhoneField(),

          // Password
          PasswordField(),

          // Password confirmation
          ConfirmPasswordField(),

          // Referral
          ReferralField(),

          // Terms and privacy policy
          TermsAndPrivacyButton(),

          // Register button
          RegisterButton(),

          // Already have an account
          // AlreadyHaveAccountButton(),

          // AssistanceButton(),
          AuthSocialContainer(isLogin: false),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
