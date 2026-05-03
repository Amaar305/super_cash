import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DirectAirtimeGiveawayPage extends StatelessWidget {
  const DirectAirtimeGiveawayPage({super.key, required this.giveawayTypeId});
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DirectAirtimeGiveawayCubit(
        addDirectAirtimePhoneGiveawayUseCase: serviceLocator(),
        claimDirectAirtimeGiveawayUseCase: serviceLocator(),
        getDirectAirtimesGiveawayUseCase: serviceLocator(),
        giveawayTypeid: giveawayTypeId,
      ),
      child: DirectAirtimeGiveawayView(),
    );
  }
}

class DirectAirtimeGiveawayView extends StatefulWidget {
  const DirectAirtimeGiveawayView({super.key});

  @override
  State<DirectAirtimeGiveawayView> createState() =>
      _DirectAirtimeGiveawayViewState();
}

class _DirectAirtimeGiveawayViewState extends State<DirectAirtimeGiveawayView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DirectAirtimeGiveawayCubit>().getAirtimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Direct Airtime Giveaway')),
      body:
          BlocListener<DirectAirtimeGiveawayCubit, DirectAirtimeGiveawayState>(
            listenWhen: (p, c) => p.status != c.status,
            listener: (context, state) {
              if (state.status.isLoading) {
                showLoadingOverlay(context);
              } else {
                hideLoadingOverlay();
              }
              if (state.status.isFailure && state.message.isNotEmpty) {
                openSnackbar(SnackbarMessage.error(title: state.message));
              }
            },
            child: RefreshIndicator.adaptive(
              onRefresh: context.read<DirectAirtimeGiveawayCubit>().getAirtimes,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DirectAirtimeHeader(),
                          const Gap.v(AppSpacing.xlg),
                          DirectAirtimeNetworkFilter(),
                          const Gap.v(AppSpacing.xlg),
                          Text(
                            'Available Giveaway',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: const Color(0xFF16233C),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const Gap.v(AppSpacing.lg),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      0,
                      AppSpacing.lg,
                      AppSpacing.xlg,
                    ),
                    sliver: DirectAirtimeGiveawayListView(),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

class DirectAirtimeHeader extends StatelessWidget {
  const DirectAirtimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context
        .select<DirectAirtimeGiveawayCubit, DirectAirtimeGiveawayState>(
          (value) => value.state,
        );
    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'TOTAL AiRTIME POOL',
            icon: Icons.phone,
            subtitle: state.totalAirtime.planDisplayAmount,
            footerTitle: 'Across all active drops',
          ),
        ),
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'AVAILABLE TO CLAIM',
            icon: Icons.phone_callback,
            iconColor: Color(0xff006E2F),
            subtitle: state.availableAirtime.planDisplayAmount,
            footerTitle:
                '${state.remainingPercent.toStringAsFixed(1)}% REMAINING',
            footerTitleColor: Color(0xff006E2F),
            extraWidget: SizedBox(
              width: double.infinity,
              height: 4,
              child: LinearProgressIndicator(
                value: state.remainingPercent,
                color: Color(0xff006E2F),
                borderRadius: BorderRadius.circular(999),
                // minHeight: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
