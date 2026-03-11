import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawaysPage extends StatelessWidget {
  const GiveawaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GiveawayCubit(
        getGiveawayTypesUseCase: serviceLocator(),
        getGiveawaysUseCase: serviceLocator(),
      ),
      child: GiveawayView(),
    );
  }
}

class GiveawayView extends StatefulWidget {
  const GiveawayView({super.key});

  @override
  State<GiveawayView> createState() => _GiveawayViewState();
}

class _GiveawayViewState extends State<GiveawayView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GiveawayCubit>().getGiveaways();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('Giveaways'),
        leading: AppLeadingAppBarWidget(onTap: () => context.pop()),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: BlocConsumer<GiveawayCubit, GiveawayState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isLoading) {
              showLoadingOverlay(context);
            } else {
              hideLoadingOverlay();
            }
            if (state.status.isFailure && state.errorMessage != null) {
              openSnackbar(
                SnackbarMessage.error(title: state.errorMessage ?? ''),
                clearIfQueue: true,
              );
            }
          },
          buildWhen: (previous, current) => previous.types != current.types,

          builder: (context, state) {
            return Column(
              children: [
                FeaturedGiveawayCard(),
                Gap.v(14),
                _HistoryWinnersRow(),
                Gap.v(18),
                GiveawayStatusLineWidget(),
                Gap.v(16),
                SectionHeader(title: "Live & Upcoming", actionText: "View All"),
                Gap.v(12),
                LiveAndUpcomingGiveaways(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LiveAndUpcomingGiveaways extends StatelessWidget {
  const LiveAndUpcomingGiveaways({super.key});

  @override
  Widget build(BuildContext context) {
    final otherGiveaways = context.watch<GiveawayCubit>().state.otherGiveaways;

    if (otherGiveaways.isEmpty) {
      return Center(child: Text('No available giveaways'));
    }

    void naviagte(BuildContext context, Giveaway giveaway) {
      if (giveaway.status == UpcomingGiveawayStatus.cancelled) {
        return;
      } else if (giveaway.giveawayType.code.contains('airtime')) {
        context.pushNamed(
          RNames.airtimeGiveaway,
          pathParameters: {
            'giveaway_type_id': giveaway.giveawayType.id.toString(),
          },
        );
      } else {
        return;
      }
    }

    return Column(
      spacing: 12,
      children: otherGiveaways.map((giveaway) {
        return GiveawayTile(
          icon: getIcon(giveaway.giveawayType.code),
          iconBg: Color(0xFFE7FBF2),
          iconColor: AppColors.blue,
          title: giveaway.giveawayType.name,
          subtitle: giveaway.description,
          status: giveaway.status,
          isDisabled: giveaway.status == UpcomingGiveawayStatus.cancelled,
          onTap: () => naviagte(context, giveaway),
        );
      }).toList(),
    );
  }

  IconData getIcon(String code) {
    switch (code) {
      case 'airtime-pin':
        return Icons.local_phone_rounded;
      case 'data-code':
        return Icons.wifi_rounded;
      case 'bonus_pack':
        return Icons.card_giftcard_rounded;
      case 'movie_premiere':
        return Icons.movie_creation_rounded;
      default:
        return Icons.local_phone_rounded;
    }
  }
}

class _HistoryWinnersRow extends StatelessWidget {
  const _HistoryWinnersRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.md,
      children: [
        Expanded(
          child: OutlineAction(
            icon: Icons.history_rounded,
            label: "History",
            onTap: () => context.pushNamed(RNames.giveawayHistory),
          ),
        ),

        Expanded(
          child: OutlineAction(
            icon: Icons.emoji_events_rounded,
            label: "Winners",
            iconColor: Color(0xFFFFBF00),
            onTap: () => context.pushNamed(RNames.giveawayWinners),
          ),
        ),
      ],
    );
  }
}
