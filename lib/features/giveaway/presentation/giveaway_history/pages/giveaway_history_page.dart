import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
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

class GiveawayHistoryView extends StatelessWidget {
  const GiveawayHistoryView({super.key});

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
        buildWhen: (previous, current) =>
            previous.filteredData != current.filteredData,
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(AppSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    spacing: AppSpacing.md,
                    children: [GiveawayHistoryMetricsSection(), newMethod()],
                  ),
                ),
              ),
              if (state.filteredData.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  sliver: SliverToBoxAdapter(
                    child: AppEmptyState(
                      title: 'No available history',
                      action: TextButton(
                        onPressed: context
                            .read<GiveawayHistoryCubit>()
                            .getHistories,
                        child: Text('Refresh'),
                      ),
                    ),
                  ),
                )
              else
                SliverList.builder(
                  itemCount: state.filteredData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.sm,
                      ),
                      child: GiveawayCard(
                        giveawayHistory: state.filteredData[index],
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget newMethod() {
    return Builder(
      builder: (context) {
        final net = context.read<GiveawayHistoryCubit>().state.quickNetwork;
        final type = context.read<GiveawayHistoryCubit>().state.selectedType;

        final high = context.read<GiveawayHistoryCubit>().state.highAmount;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppFilterButton(
              onFilterTapped: () {
                showHistoryGiveawayFilterSheet(
                  context,
                  quickNetwork: net,
                  selectedType: type,
                  high: high,
                  onApply: (network, type, highAmount) {
                    context.read<GiveawayHistoryCubit>().applyFilters(
                      network,
                      type,
                      highAmount,
                    );
                  },
                  onClear: context
                      .read<GiveawayHistoryCubit>()
                      .refreshTransactions,
                );
              },
            ),
            TextButton.icon(
              onPressed: context
                  .read<GiveawayHistoryCubit>()
                  .refreshTransactions,
              label: Text('Clear Filters'),
              style: TextButton.styleFrom(foregroundColor: AppColors.blue),
              icon: Icon(Icons.clear_all, size: 16),
            ),
          ],
        );
      },
    );
  }
}

class GiveawayHistoryTab extends StatelessWidget {
  const GiveawayHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTab(
      backgroundColor: const Color(0xFF2F2E2E),
      children: [
        AppTabItem(label: 'Airtime', onTap: () {}, activeTab: true),
        AppTabItem(label: 'Data'),
      ],
    );
  }
}

void showHistoryGiveawayFilterSheet(
  BuildContext context, {
  required void Function(String? network, String? type, String? highAmount)
  onApply,
  required void Function() onClear,
  String? quickNetwork,
  String? selectedType,
  String? high,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filters",
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: AppSpacing.md,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          quickNetwork = null;
                          selectedType = null;
                          selectedType = null;
                        });
                        onClear();
                      },
                      child: Text(
                        "Clear",
                        style: poppinsTextStyle(
                          fontWeight: AppFontWeight.semiBold,
                          fontSize: AppSpacing.md,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Network
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Network",
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppSpacing.md,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ["Mtn", "Airtel", "Glo", "9Mobile"].map((label) {
                    final selected = quickNetwork == label;
                    return ChoiceChip(
                      label: Text(
                        label,
                        style: poppinsTextStyle(
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppSpacing.md,
                        ),
                      ),
                      selected: selected,
                      selectedColor: Colors.blue.shade100,
                      onSelected: (_) {
                        setState(() {
                          quickNetwork = label;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Status Chips
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Giveaway type",
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppSpacing.md,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: [null, 'airtime', 'data', 'product'].map((status) {
                    final isSelected = selectedType == status;

                    final label = status == null ? "All" : status.capitalize;
                    final color = status == null
                        ? AppColors.grey
                        : status.contains('product')
                        ? AppColors.green
                        : status.contains('airtime')
                        ? AppColors.blue
                        : AppColors.red;

                    return ChoiceChip(
                      label: Text(
                        label,
                        style: poppinsTextStyle(
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppSpacing.md,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: color.withValues(alpha: 0.15),
                      labelStyle: TextStyle(
                        color: isSelected ? color : Colors.black87,
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedType = status;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Amount Chips
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Amount",
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppSpacing.md,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ["High to Low", "Low to High"].map((label) {
                    final selected = high?.contains(label);
                    return ChoiceChip(
                      label: Text(
                        label,
                        style: poppinsTextStyle(
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppSpacing.md,
                        ),
                      ),
                      selected: selected ?? false,
                      selectedColor: Colors.blue.shade100,
                      onSelected: (_) {
                        setState(() {
                          high = label;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Show results',
                  onPressed: () {
                    Navigator.pop(context);
                    onApply(quickNetwork, selectedType, high);
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}
