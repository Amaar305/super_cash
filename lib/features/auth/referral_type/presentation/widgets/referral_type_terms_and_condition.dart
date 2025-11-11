import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralTypeTermsAndCondition extends StatefulWidget {
  const ReferralTypeTermsAndCondition({super.key});

  @override
  State<ReferralTypeTermsAndCondition> createState() =>
      _ReferralTypeTermsAndConditionState();
}

class _ReferralTypeTermsAndConditionState
    extends State<ReferralTypeTermsAndCondition> {
  late final ReferralTypeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ReferralTypeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final terms = context.select(
      (ReferralTypeCubit element) => element.state.termsContidition,
    );

    return Row(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          child: Checkbox(
            value: terms,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: BorderSide(width: 0.5),
            onChanged: (val) {
              _cubit.changeTermsCondition();
            },
          ),
        ),
        _buildTerms(false),
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
