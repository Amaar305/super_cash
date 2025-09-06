import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamPinButton extends StatelessWidget {
  const ExamPinButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> onExamPinConfirmation() {
      final compliter = Completer<bool>();

      context.showExtraBottomSheet(
        title: AppStrings.confirmation,
        description: 'Are you sure you want to purchase a WAEC EXAM PIN.',
        icon: Assets.images.warning.image(),
        children: [
          PrimaryButton(
            label: AppStrings.yesContinue,
            onPressed: () {
              context.pop();
              compliter.complete(true);
            },
          ),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  isLoading: false,
                  label: AppStrings.cancel,
                  onPressed: () {
                    context.pop();
                    compliter.complete(false);
                  },
                ),
              ),
            ],
          ),
        ],
      );

      return compliter.future;
    }

    void onExamPinPurchased() {
      context.showExtraBottomSheet(
        title: 'Exam Pin Purchase Successful!',
        description: 'Your exam pin purchase was successful.',
        icon: Assets.images.circleCheck.image(),
        children: [
          Text(
            'Token Number',
            style: TextStyle(
              fontSize: AppSpacing.lg + 1,
              fontWeight: AppFontWeight.bold,
              color: AppColors.deepBlue,
            ),
          ),
          Row(
            spacing: AppSpacing.sm,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '0000-0000- 00000-000000',
                style: TextStyle(
                  fontWeight: AppFontWeight.medium,
                  fontSize: AppSpacing.lg,
                ),
              ),
              Tappable.scaled(
                onTap: () {},
                child: Icon(Icons.copy_outlined, size: AppSpacing.lg),
              ),
            ],
          ),
          Gap.v(AppSpacing.md),
          PrimaryButton(label: AppStrings.done, onPressed: context.pop),
          TextButton(
            onPressed: () {},
            child: Text(
              AppStrings.rateUs,
              style: TextStyle(
                fontSize: AppSpacing.lg,
                fontWeight: AppFontWeight.semiBold,
                color: AppColors.deepBlue,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: AppColors.blue,
              ),
            ),
          ),
        ],
      );
    }

    return PrimaryButton(
      label: AppStrings.buy,
      onPressed: () async {
        final result = await onExamPinConfirmation();

        if (result && context.mounted) onExamPinPurchased();
      },
    );
  }
}
