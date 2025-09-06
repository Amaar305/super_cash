import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class AddressVerificationForm extends StatelessWidget {
  const AddressVerificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xlg,
      children: [
        AddressVerificationCountryField(),
        AddressVerificationStateField(),
        AddressVerificationCityField(),
        AddressVerificationHouseNumberField(),
        AddressVerificationHouseAddressField(),
        AddressVerificationPostalCodeField(),
      ],
    );
  }
}
