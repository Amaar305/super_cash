part of '../pages/product_giveaway_details_page.dart';

class _ActionFooter extends StatelessWidget {
  const _ActionFooter({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final isDisabled = details.isClosed;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        decoration: const BoxDecoration(
          color: ProductGiveawayDetailsPage._pageBackground,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 18,
              offset: Offset(0, -6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isDisabled ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProductGiveawayDetailsPage._primaryCta,
                  disabledBackgroundColor: const Color.fromARGB(
                    255,
                    184,
                    192,
                    199,
                  ),
                  foregroundColor: AppColors.white,
                  minimumSize: const Size.fromHeight(54),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.how_to_reg_rounded, size: 18),
                label: Text(
                  'Enter Giveaway',
                  style: poppinsTextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 227, 229, 232),
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Color(0xFFD6E0DC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.verified_user_outlined, size: 18),
                label: Text(
                  'Check Eligibility',
                  style: poppinsTextStyle(
                    color: const Color.fromARGB(255, 33, 34, 33),
                    fontSize: 12,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
