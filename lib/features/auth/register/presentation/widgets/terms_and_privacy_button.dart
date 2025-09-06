import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../auth.dart';

class TermsAndPrivacyButton extends StatefulWidget {
  const TermsAndPrivacyButton({super.key});

  @override
  State<TermsAndPrivacyButton> createState() => _TermsAndPrivacyButtonState();
}

class _TermsAndPrivacyButtonState extends State<TermsAndPrivacyButton> {
  final _debouncer = Debouncer();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (RegisterCubit cubit) => cubit.state.status.isLoading,
    );
    final termsCondition = context.select(
      (RegisterCubit cubit) => cubit.state.agreedToTermsAndCondition,
    );

    return Row(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          child: Checkbox(
            value: termsCondition,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: BorderSide(width: 0.5),
            onChanged: (val) => _cubit.changeTermsCondition(),
          ),
        ),
        _buildTerms(isLoading),
      ],
    );
  }

  Widget _buildTerms(bool isLoading) {
    final double fontSize = 12;
    return Expanded(
      child: Column(
        children: [
          Text(
            AppStrings.termsAndPrivacy,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300),
          ),
          Row(
            children: [
              Tappable.scaled(
                onTap: isLoading
                    ? null
                    : () {
                        launchLink(
                          'https://supercash2025.blogspot.com/2025/08/privacy-and-policy-for-super-cash.html',
                        );
                        _cubit.changeTermsCondition();
                      },
                child: Text(
                  AppStrings.privacyPolicy,
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                AppStrings.and,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Tappable(
                onTap: isLoading
                    ? null
                    : () {
                        launchLink(
                          'https://supercash2025.blogspot.com/2025/08/welcome-to-super-cash-these-terms.html',
                        );
                        _cubit.changeTermsCondition();
                      },
                child: Text(
                  AppStrings.termsOfService,
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
