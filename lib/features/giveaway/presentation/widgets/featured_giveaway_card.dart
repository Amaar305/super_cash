import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class FeaturedGiveawayCard extends StatelessWidget {
  const FeaturedGiveawayCard({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFFFFFFFF);
    const subText = Color.fromARGB(255, 226, 226, 226);

    final giveaways = context.watch<GiveawayCubit>().state.upcomingGiveaways;

    if (giveaways.isEmpty) return SizedBox.shrink();

    return FeaturedGiveawayContainer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final giveaway = giveaways[index];
          return UpcomingFeaaturedGiveaway(
            textDark: textDark,
            subText: subText,
            giveaway: giveaway,
          );
        },
        separatorBuilder: (context, index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap.v(14),
            Divider(color: AppColors.background, thickness: 0.3),
          ],
        ),
        itemCount: giveaways.length,
      ),
    );
  }
}
