import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

import 'package:super_cash/features/giveaway/giveaway.dart';

class AirtimeGiveawayPage extends StatelessWidget {
  const AirtimeGiveawayPage({super.key, required this.giveawayTypeId});
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AirtimeGiveawayCubit(
        giveawayTypeId: giveawayTypeId,
        getAirtimeGiveawayPinsUseCase:
            serviceLocator<GetAirtimeGiveawayPinsUseCase>(),
        claimAirtimeGiveawayUseCase:
            serviceLocator<ClaimAirtimeGiveawayUseCase>(),
      ),
      child: AirtimeGiveawayView(),
    );
  }
}

class AirtimeGiveawayView extends StatefulWidget {
  const AirtimeGiveawayView({super.key});

  @override
  State<AirtimeGiveawayView> createState() => _AirtimeGiveawayViewState();
}

class _AirtimeGiveawayViewState extends State<AirtimeGiveawayView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AirtimeGiveawayCubit>().getAirtimeGiveawayPins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('Available Airtime Giveaway'),
        centerTitle: false,
        leading: AppLeadingAppBarWidget(onTap: () => context.pop()),
      ),
      body: BlocListener<AirtimeGiveawayCubit, AirtimeGiveawayState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isLoading) {
            showLoadingOverlay(context);
          } else {
            hideLoadingOverlay();
          }
          if ((state.status.isFailure || state.status.isProcressingError) &&
              state.errorMessage != null) {
            openSnackbar(
              SnackbarMessage.error(title: state.errorMessage ?? ''),
              clearIfQueue: true,
            );
          }

          if (state.status.isProcessing) {
            showAdaptiveDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: AppSpacing.lg,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.blue,
                            strokeWidth: 2,
                          ),

                          Text('Processing your claim...'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state.status.isProcressingError) {
            context.pop();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFilterButton(
                    onFilterTapped: () {
                      showFilterBotthomSheet(context);
                    },
                  ),
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
              Gap.v(AppSpacing.lg),
              Expanded(child: AirtimeGiveawayListView()),
            ],
          ),
        ),
      ),
    );
  }
}

void showFilterBotthomSheet(BuildContext context) {
  String? quickNetwork;
  String? selectedStatus;
  String? high;
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
                        // setState(() {
                        //   selectedRange = null;
                        //   selectedStatus = null;
                        //   quickPeriod = null;
                        //   selectedType = null;
                        // });
                        // onClear();
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
                    "Status",
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppSpacing.md,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: [null, 'claimed', 'new'].map((status) {
                    final isSelected = selectedStatus == status;

                    final label = status == null ? "All" : status.capitalize;
                    final color = status == null
                        ? AppColors.grey
                        : status.contains('claimed')
                        ? AppColors.green
                        : status == 'new'
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
                          selectedStatus = status;
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
                    // onApply(
                    //   selectedRange?.start,
                    //   selectedRange?.end,
                    //   selectedStatus,
                    //   selectedType,
                    // );
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
