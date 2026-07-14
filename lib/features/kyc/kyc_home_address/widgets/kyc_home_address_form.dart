import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'kyc_home_address_city_field.dart';
import 'kyc_home_address_country_field.dart';
import 'kyc_home_address_house_no_field.dart';
import 'kyc_home_address_lga_field.dart';
import 'kyc_home_address_postal_code_field.dart';
import 'kyc_home_address_state_field.dart';
import 'kyc_home_address_street_field.dart';

class KycHomeAddressForm extends StatelessWidget {
  const KycHomeAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: AppSpacing.xlg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KycHomeAddressCountryField(),
        Row(
          spacing: AppSpacing.md,
          children: [
            Expanded(child: KycHomeAddressStateField()),
            Expanded(child: KycHomeAddressCityField()),
          ],
        ),
        SizedBox(),
        Row(
          children: [
            Expanded(child: KycHomeAddressLgaField()),
            Expanded(child: KycHomeAddressHouseNoField()),
          ],
        ),
        KycHomeAddressStreetField(),
        KycHomeAddressPostalCodeField(),
      ],
    );
  }
}
