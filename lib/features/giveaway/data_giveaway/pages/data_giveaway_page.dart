import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DataGiveawayPage extends StatelessWidget {
  const DataGiveawayPage({super.key, required this.giveawayTypeId});
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataGiveawayCubit(
        getDataGiveawaysUseCase: serviceLocator(),
        claimDataGiveawayUseCase: serviceLocator<ClaimDataGiveawayUseCase>(),
        giveawayTypeId: giveawayTypeId,
        user: context.read<AppCubit>().state.user!,
      ),
      child: DataGiveawayView(),
    );
  }
}

class DataGiveawayView extends StatefulWidget {
  const DataGiveawayView({super.key});

  @override
  State<DataGiveawayView> createState() => _DataGiveawayViewState();
}

class _DataGiveawayViewState extends State<DataGiveawayView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataGiveawayCubit>().getPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Data Giveaway')),
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<DataGiveawayCubit>().getPlans,
        child: BlocListener<DataGiveawayCubit, DataGiveawayState>(
          listenWhen: (previous, current) => previous.status != current.status,
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
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                      DataGiveawayHeader(),
                      const Gap.v(AppSpacing.xlg),
                      DataNetworkFilterChips(),
                      const Gap.v(AppSpacing.xlg),
                      Text(
                        'Available Giveaway',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFF16233C),
                              fontWeight: FontWeight.w600,
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
                sliver: DataGiveawayListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataGiveawayHeader extends StatelessWidget {
  const DataGiveawayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<DataGiveawayCubit, DataGiveawayState>(
      (value) => value.state,
    );
    final displayGB = state.totalGB.toStringAsFixed(2).split('.').last == '00'
        ? state.totalGB.toStringAsFixed(0)
        : state.totalGB.toStringAsFixed(2);
    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'TOTAL GB POOL',
            icon: Icons.signal_cellular_alt,
            subtitle: '${displayGB}GB',
            footerTitle: 'Across all active drops',
          ),
        ),
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'AVAILABLE TO CLAIM',
            icon: Icons.signal_cellular_alt,
            iconColor: Color(0xff006E2F),
            subtitle: '${state.availableGB.toStringAsFixed(0)}GB',
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
