import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/common/common.dart';
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
      child: GiveawaysView(),
    );
  }
}

class GiveawaysView extends StatefulWidget {
  const GiveawaysView({super.key});

  @override
  State<GiveawaysView> createState() => _GiveawaysViewState();
}

class _GiveawaysViewState extends State<GiveawaysView> {
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
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<GiveawayCubit>().getGiveaways,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: BlocConsumer<GiveawayCubit, GiveawayState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
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
                  _HistoryWinnersRow(),
                  Gap.v(14),
                  FeaturedGiveawayCard(),

                  Gap.v(18),
                  GiveawayStatusLineWidget(),
                  Gap.v(16),

                  LiveAndUpcomingGiveaways(),
                ],
              );
            },
          ),
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
      return AppEmptyState(
        title: 'No available giveaways.',
        fontSize: 12,
        padding: EdgeInsets.zero,
        iconSize: 30,
        height: 70,
        width: 70,
      );
    }

    void naviagte(BuildContext context, Giveaway giveaway) {
      if (giveaway.status.isCancelled || giveaway.status.isCompleted) {
        return;
      }

      if (giveaway.giveawayType.code == 'airtime-direct') {
        context.pushNamed(
          RNames.directAirtimeGiveaway,
          pathParameters: {
            'giveaway_type_id': giveaway.giveawayType.id.toString(),
          },
        );
      } else if (giveaway.giveawayType.code.contains('airtime')) {
        context.pushNamed(
          RNames.airtimeGiveaway,
          pathParameters: {
            'giveaway_type_id': giveaway.giveawayType.id.toString(),
          },
        );
      } else if (giveaway.giveawayType.code.contains('product')) {
        context.pushNamed(
          RNames.productGiveaway,
          pathParameters: {
            'giveaway_type_id': giveaway.giveawayType.id.toString(),
          },
        );
      } else if (giveaway.giveawayType.code.contains('data')) {
        context.pushNamed(
          RNames.dataGiveaway,
          pathParameters: {
            'giveaway_type_id': giveaway.giveawayType.id.toString(),
          },
        );
      } else if (giveaway.giveawayType.code.contains('cash')) {
        context.pushNamed(
          RNames.cashGiveaway,
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
          endsAt: giveaway.endsAt,

          isDisabled:
              giveaway.status.isCancelled || giveaway.status.isCompleted,
          onTap: () => naviagte(context, giveaway),
          image: giveaway.image,
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
        Expanded(child: HistoryButton()),

        Expanded(
          child: OutlineAction(
            icon: Icons.emoji_events_outlined,
            label: "Winners",
            iconColor: AppColors.white,
            onTap: () => context.pushNamed(RNames.giveawayWinners),
          ),
        ),
      ],
    );
  }
}

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () => context.pushNamed(RNames.giveawayHistory),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: AppColors.walletGradient,
          borderRadius: BorderRadius.circular(12),
          color: AppColors.darkGrey,
        ),

        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.sm,
            children: [
              Icon(Icons.history_rounded, size: 20, color: AppColors.white),
              Text(
                'History',
                style: GoogleFonts.exo(
                  // fontSize: 12,
                  color: AppColors.white,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
