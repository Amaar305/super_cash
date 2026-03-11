import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayHistoryPage extends StatelessWidget {
  const GiveawayHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GiveawayHistoryCubit(
        getGiveawayHistoriesUseCase:
            serviceLocator<GetGiveawayHistoriesUseCase>(),
      )..getHistories(),
      child: GiveawayHistoryView(),
    );
  }
}

class GiveawayHistoryView extends StatefulWidget {
  const GiveawayHistoryView({super.key});

  @override
  State<GiveawayHistoryView> createState() => _GiveawayHistoryViewState();
}

class _GiveawayHistoryViewState extends State<GiveawayHistoryView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Claim History')),

      body: BlocConsumer<GiveawayHistoryCubit, GiveawayHistoryState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isLoading) {
            showLoadingOverlay(context);
          } else {
            hideLoadingOverlay();
          }
          if (state.status.isFailure && state.message != null) {
            openSnackbar(
              SnackbarMessage.error(title: state.message ?? ''),
              clearIfQueue: true,
            );
          }
        },
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              spacing: AppSpacing.lg,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppFilterButton(onFilterTapped: () {}),
                    TextButton.icon(
                      onPressed: () {},
                      label: Text('Clear Filters'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.blue,
                      ),
                      icon: Icon(Icons.clear_all, size: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: GiveawayHistoryListView(
                    histories: state.data,
                    onLoadMore: context
                        .read<GiveawayHistoryCubit>()
                        .getHistories,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
