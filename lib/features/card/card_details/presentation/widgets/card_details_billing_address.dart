import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/card/card_details/presentation/widgets/card_detail_title_value.dart';

class CardDetailsBillingAddress extends StatelessWidget {
  final BillingAddress? billingAddress;
  final CardDetails? cardDetails;

  const CardDetailsBillingAddress({
    super.key,
    this.billingAddress,
    this.cardDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          if (billingAddress != null) ...[
            CardDetailTitleWithValue(
              title: 'Address',
              value: billingAddress?.billingAddress1,
            ),
            CardDetailTitleWithValue(
              title: 'City',
              value: billingAddress?.billingCity,
            ),

            CardDetailTitleWithValue(
              title: 'Country',
              value: billingAddress?.billingCountry,
            ),
            CardDetailTitleWithValue(
              title: 'Country Code',
              value: billingAddress?.countryCode,
            ),
            CardDetailTitleWithValue(
              title: 'Zip Code',
              value: billingAddress?.billingZipCode,
            ),

            CardDetailTitleWithValue(
              title: 'State',
              value: billingAddress?.state,
            ),
            CardDetailTitleWithValue(
              title: 'State Code',
              value: billingAddress?.stateCode,
            ),
          ] else if (cardDetails != null) ...[
            CardDetailTitleWithValue(
              title: 'Card Name',
              value: cardDetails?.cardName,
            ),
            CardDetailTitleWithValue(
              title: 'Card Number',
              value: cardDetails?.cardNumber,
            ),

            CardDetailTitleWithValue(
              title: 'Expiring Date',
              value: cardDetails?.formattedExpiryDate,
            ),
            CardDetailTitleWithValue(title: 'CVV', value: cardDetails?.cvv),
          ],
        ],
      ),
    );
  }
}
