part of '../pages/giveway_detail_page.dart';

class _ActionFooter extends StatelessWidget {
  const _ActionFooter({required this.details, required this.giveawayTypeId});

  final _GiveawayDetails details;
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    final isProductGiveaway = details.isProductGiveaway;

    final isDisabled = details.isClosed;
    final isLoading = context.select(
      (GiveawayDetailCubit cubit) => cubit.state.status.isLoading,
    );

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        decoration: const BoxDecoration(
          color: GivewayDetailPage._pageBackground,
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
                onPressed: isLoading
                    ? null
                    : isProductGiveaway
                    ? () => context.pushNamed(
                        RNames.productGiveaway,
                        pathParameters: {'giveaway_type_id': giveawayTypeId},
                        extra:
                            details.upcomingGiveawayStatus ==
                                UpcomingGiveawayStatus.upcoming
                            ? false
                            : true,
                      )
                    : isDisabled
                    ? null
                    : () => context
                          .read<GiveawayDetailCubit>()
                          .navigateToProductGiveaway(),

                style: ElevatedButton.styleFrom(
                  backgroundColor: GivewayDetailPage._primaryCta,
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
                icon: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : const Icon(Icons.how_to_reg_rounded, size: 18),
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
                onPressed: isLoading
                    ? null
                    : () => context
                          .read<GiveawayDetailCubit>()
                          .checkEligibility(giveawayTypeId: giveawayTypeId),
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
