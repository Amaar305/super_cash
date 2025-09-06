import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/smile/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmilePhoneField extends StatelessWidget {
  const SmilePhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SmileCubit cubit) => cubit.state.status.isLoading,
    );
    final isPhoneNumber = context.select(
      (SmileCubit cubit) => cubit.state.isPhoneNumber,
    );
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          !isPhoneNumber
              ? AppStrings.enterAccountNumber
              : AppStrings.enterBeneficiaryPhoneNumber,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField(
          hintText: !isPhoneNumber
              ? AppStrings.enterAccountNumber
              : "Enter ${AppStrings.phoneNumber.toLowerCase()}",
          filled: Config.filled,
          enabled: !isLoading,
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          suffixIcon: !isPhoneNumber
              ? null
              : Tappable.faded(
                  onTap: () {},
                  child: Icon(Icons.contacts_outlined, color: AppColors.blue),
                ),
        ),
      ],
    );
  }
}
