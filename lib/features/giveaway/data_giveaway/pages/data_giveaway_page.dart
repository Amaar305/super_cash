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
      )..getPlans(),
      child: DataGiveawayView(),
    );
  }
}

class DataGiveawayView extends StatelessWidget {
  const DataGiveawayView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Data Giveaway')),
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<DataGiveawayCubit>().getPlans,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xlg,
          ),
          child: BlocListener<DataGiveawayCubit, DataGiveawayState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure && state.message.isNotEmpty) {
                openSnackbar(SnackbarMessage.error(title: state.message));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap.v(AppSpacing.xlg),
                DataGiveawayNetworkFilterChips(
                  labels: ['All', 'MTN', 'Airtel', 'GLO', '9Mobile'],
                  selectedIndex: 1,
                ),
                const Gap.v(AppSpacing.xlg),
                Text(
                  'Available Giveaway',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF16233C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap.v(AppSpacing.lg),
                DataGiveawayListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataGiveawayListView extends StatelessWidget {
  const DataGiveawayListView({super.key});

  @override
  Widget build(BuildContext context) {
    final giveaways = context.select(
      (DataGiveawayCubit element) => element.state.dataPlans,
    );
    return Expanded(
      child: ListView.builder(
        itemCount: giveaways.length,
        itemBuilder: (context, index) {
          final giveaway = giveaways[index];
          return DataGiveawayCard(
            dataName: giveaway.dataName,
            dataSize: giveaway.dataSize,
            network: giveaway.network,
            dataQuantity: giveaway.dataQuantity,
            dataQuantityRemaining: giveaway.dataQuantityRemaining,
            isAvailable: giveaway.isAvailable,
            onClaimed: () async {
              final cubit = context.read<DataGiveawayCubit>();
              final succes = await showModalBottomSheet<DataGiveawayItem?>(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                showDragHandle: false,
                builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: DataGiveawayClaimSheet(dataGiveawayItem: giveaway),
                  );
                },
              );
              if (succes != null && context.mounted) {
                context.showConfirmationBottomSheet(
                  title: 'Your data has been successfully sent..',
                  okText: 'Done',
                );
              }
            },
          );
        },
      ),
    );
  }
}
