import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class SmileForm extends StatelessWidget {
  const SmileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isPhoneNumber = context.select(
      (SmileCubit cubit) => cubit.state.isPhoneNumber,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [
        SmilePhoneField(),
        if (isPhoneNumber)
          Row(
            spacing: AppSpacing.lg,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppMiniButton(label: AppStrings.beneficiary),
              AppMiniButton(label: AppStrings.beneficiary),
            ],
          ),
      ],
    );
  }
}
