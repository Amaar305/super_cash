import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardDetailsBillingAddress extends StatelessWidget {
  final BillingAddress? billingAddress;

  const CardDetailsBillingAddress({
    super.key,
    required this.billingAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          _buildDetailTile('Address', billingAddress?.billingAddress1),
          _buildDetailTile('City', billingAddress?.billingCity),
          _buildDetailTile('Country', billingAddress?.billingCountry),
          _buildDetailTile('Zip Code', billingAddress?.billingZipCode),
          _buildDetailTile('Country Code', billingAddress?.countryCode),
          _buildDetailTile('State', billingAddress?.state),
          _buildDetailTile('State Code', billingAddress?.stateCode),
        ],
      ),
    );
  }

  Widget _buildDetailTile(String title, String? value) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppSpacing.md + 1,
                    fontWeight: AppFontWeight.light,
                  ),
                ),
                const Spacer(),
                Text(
                  value ?? '',
                  style: const TextStyle(
                    fontSize: AppSpacing.md,
                    fontWeight: AppFontWeight.light,
                  ),
                ),
                const Gap.h(AppSpacing.sm),
                // ignore: deprecated_member_use
                Tappable.faded(
                    onTap: () {
                      copyText(context, value ?? '', '$title copied');
                    },
                    child: Assets.icons.copy.svg(
                      // ignore: deprecated_member_use
                      color: AppColors.buttonColor,
                    )),
              ],
            ),
            const Divider(thickness: 0.3),
          ],
        ),
      );
    });
  }
}
