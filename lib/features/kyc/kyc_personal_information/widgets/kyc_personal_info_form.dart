import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/widgets/kyc_personal_info_dob_field.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/widgets/kyc_personal_info_first_name_field.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/widgets/kyc_personal_info_gender_field.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/widgets/kyc_personal_info_last_name_field.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/widgets/kyc_personal_info_middle_name_field.dart';

class KycPersonalInfoForm extends StatelessWidget {
  const KycPersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xlg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        KycPersonalInfoFirstNameField(),
        KycPersonalInfoLastNameField(),
        KycPersonalInfoMiddleNameField(),
        KycPersonalInfoDobField(),
        KycPersonalInfoGenderField(),
      ],
    );
  }
}
