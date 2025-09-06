import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:shared/shared.dart';

void showTransactionFilterDialog({
  required BuildContext context,
  required void Function(
    DateTime? start,
    DateTime? end,
    TransactionStatus?,
    // TransactionType?,
  )
  onApply,
}) {
  DateTime? startDate;
  DateTime? endDate;
  TransactionStatus? selectedStatus;
  // TransactionType? selectedType;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Filter Transactions"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Select Date Range"),
                  SizedBox(height: 10),
                  RangePicker(
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    selectedPeriod: startDate != null && endDate != null
                        ? DatePeriod(startDate!, endDate!)
                        : DatePeriod(DateTime.now(), DateTime.now()),
                    onChanged: (period) {
                      setState(() {
                        startDate = period.start;
                        endDate = period.end;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Transaction Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: TransactionStatus.values.map((status) {
                      final isSelected = selectedStatus == status;
                      return ChoiceChip(
                        label: Text(status.name.capitalize),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedStatus = isSelected ? null : status;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  // DropdownButtonFormField<TransactionType>(
                  //   value: selectedType,
                  //   hint: Text("Select Type"),
                  //   onChanged: (val) => setState(() => selectedType = val),
                  //   items: TransactionType.values.map((type) {
                  //     return DropdownMenuItem(
                  //       value: type,
                  //       child: Text(type.name.capitalize()),
                  //     );
                  //   }).toList(),
                  // ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onApply(startDate, endDate, selectedStatus);
                },
                child: Text("Apply"),
              ),
            ],
          );
        },
      );
    },
  );
}

void showTransactionFilterBottomSheet({
  required BuildContext context,
  required void Function(
    DateTime? start,
    DateTime? end,
    TransactionStatus?,
    // TransactionType?,
  )
  onApply,
}) {
  DateTime? startDate;
  DateTime? endDate;
  TransactionStatus? selectedStatus;
  // TransactionType? selectedType;

  context.showBottomModal(
    isScrollControlled: true,
    title: "Filter Transactions",
    titleColor: AppColors.primary2,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date Range",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                RangePicker(
                  firstDate: DateTime(2024),
                  lastDate: DateTime.now(),
                  selectedPeriod: startDate != null && endDate != null
                      ? DatePeriod(startDate!, endDate!)
                      : DatePeriod(DateTime.now(), DateTime.now()),
                  onChanged: (period) {
                    setState(() {
                      startDate = period.start;
                      endDate = period.end;
                    });
                  },
                  datePickerStyles: DatePickerRangeStyles(
                    selectedPeriodLastDecoration: BoxDecoration(
                      color: AppColors.primary2,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    selectedPeriodStartDecoration: BoxDecoration(
                      color: AppColors.primary2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    selectedPeriodMiddleDecoration: BoxDecoration(
                      color: AppColors.primary2.withValues(alpha: 0.4),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transaction Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: TransactionStatus.values.map((status) {
                    final isSelected = selectedStatus == status;
                    return ChoiceChip(
                      label: Text(status.name.capitalize),
                      selected: isSelected,
                      selectedColor: AppColors.primary2.withValues(alpha: 0.2),
                      onSelected: (_) {
                        setState(() {
                          selectedStatus = isSelected ? null : status;
                        });
                      },
                      avatar: Icon(
                        status == TransactionStatus.success
                            ? Icons.check_circle
                            : status == TransactionStatus.failed
                            ? Icons.cancel
                            : Icons.pending,
                        size: 16,
                        color: isSelected ? AppColors.primary2 : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                // SizedBox(height: 20),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text("Transaction Type",
                //       style: TextStyle(fontWeight: FontWeight.bold)),
                // ),
                // Wrap(
                //   spacing: 8,
                //   children: TransactionType.values.map((type) {
                //     final isSelected = selectedType == type;
                //     return ChoiceChip(
                //       label: Text(type.name.capitalize()),
                //       selected: isSelected,
                //       selectedColor: Colors.deepPurple[100],
                //       onSelected: (_) {
                //         setState(() {
                //           selectedType = isSelected ? null : type;
                //         });
                //       },
                //       avatar: Icon(
                //         getTypeIcon(type),
                //         size: 16,
                //         color: isSelected ? Colors.deepPurple : Colors.grey,
                //       ),
                //     );
                //   }).toList(),
                // ),
                SizedBox(height: 30),
                PrimaryButton(
                  label: 'Apply Filters',
                  onPressed: () {
                    Navigator.pop(context);
                    onApply(startDate, endDate, selectedStatus);
                  },
                ),

                SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}

void showCustomFilterBottomSheet({
  required BuildContext context,
  required void Function(
    DateTime? start,
    DateTime? end,
    TransactionStatus?,
    TransactionType?,
  )
  onApply,
  required void Function() onClear,
}) {
  DateTimeRange? selectedRange;
  TransactionStatus? selectedStatus;
  TransactionType? selectedType;
  String? quickPeriod;
  bool showCustom = false;

  final now = DateTime.now();

  DateTimeRange getQuickRange(String label) {
    switch (label) {
      case "Today":
        return DateTimeRange(start: now, end: now);
      case "This week":
        final start = now.subtract(Duration(days: now.weekday - 1));
        final end = start.add(Duration(days: 6));
        return DateTimeRange(start: start, end: end);
      case "This month":
        final start = DateTime(now.year, now.month);
        final end = DateTime(
          now.year,
          now.month + 1,
        ).subtract(Duration(days: 1));
        return DateTimeRange(start: start, end: end);
      case "Previous month":
        final start = DateTime(now.year, now.month - 1);
        final end = DateTime(now.year, now.month).subtract(Duration(days: 1));
        return DateTimeRange(start: start, end: end);
      case "This year":
        final start = DateTime(now.year, 1, 1);
        final end = DateTime(now.year, 12, 31);
        return DateTimeRange(start: start, end: end);
      default:
        return DateTimeRange(start: now, end: now);
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              // bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          selectedRange = null;
                          selectedStatus = null;
                          quickPeriod = null;
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
                if (showCustom) ...[
                  // Custom Date Picker
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select period",
                      style: poppinsTextStyle(
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: AppSpacing.md,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    spacing: AppSpacing.sm,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.calendar_today, size: 18),
                          label: Text(
                            selectedRange?.start != null
                                ? DateFormat(
                                    "d MMM, yyyy",
                                  ).format(selectedRange!.start)
                                : "Start Date",
                            style: poppinsTextStyle(
                              fontWeight: AppFontWeight.medium,
                              fontSize: AppSpacing.md,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: AppColors.borderOutline,
                                width: 0.2,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedRange = picked;
                                quickPeriod = null;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("-", style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.calendar_today, size: 18),
                          label: Text(
                            selectedRange?.end != null
                                ? DateFormat(
                                    "d MMM, yyyy",
                                  ).format(selectedRange!.end)
                                : "End Date",
                            style: poppinsTextStyle(
                              fontWeight: AppFontWeight.medium,
                              fontSize: AppSpacing.md,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: AppColors.borderOutline,
                                width: 0.2,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedRange = picked;
                                quickPeriod = null;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],

                // Period Quick Select
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Period",
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
                  children:
                      [
                        "Today",
                        "This week",
                        "This month",
                        "Previous month",
                        "This year",
                        "Custom",
                      ].map((label) {
                        final selected = quickPeriod == label;
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
                              quickPeriod = label;
                              if (quickPeriod == 'Custom') {
                                showCustom = true;
                                return;
                              }
                              showCustom = false;

                              selectedRange = getQuickRange(label);
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
                  children:
                      [
                        null,
                        TransactionStatus.success,
                        TransactionStatus.pending,
                        TransactionStatus.failed,
                      ].map((status) {
                        final isSelected = selectedStatus == status;
                        final label = status == null
                            ? "All"
                            : status.name.capitalize;
                        final color = status == null
                            ? AppColors.grey
                            : status == TransactionStatus.success
                            ? AppColors.green
                            : status == TransactionStatus.pending
                            ? AppColors.orange
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
                // Type Chips
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Type",
                    style: poppinsTextStyle(
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppSpacing.md,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: TransactionType.values.map((type) {
                    final isSelected = selectedType == type;
                    return ChoiceChip(
                      label: Text(
                        type.name.capitalize,
                        style: poppinsTextStyle(
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppSpacing.md,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.blue.shade100,
                      onSelected: (_) {
                        setState(() {
                          selectedType = type;
                        });
                      },
                      avatar: Icon(
                        getTypeIcon(type),
                        size: 16,
                        color: isSelected ? AppColors.blue : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Apply Button
                PrimaryButton(
                  label: 'Show results',
                  onPressed: () {
                    Navigator.pop(context);
                    onApply(
                      selectedRange?.start,
                      selectedRange?.end,
                      selectedStatus,
                      selectedType,
                    );
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

IconData getTypeIcon(TransactionType type) {
  switch (type) {
    case TransactionType.airtime:
      return Icons.phone_android_outlined;
    case TransactionType.data:
      return Icons.data_usage_outlined;
    case TransactionType.cable:
      return Icons.tv_outlined;
    case TransactionType.electricity:
      return Icons.flash_on_outlined;
    case TransactionType.card:
      return Icons.credit_card_outlined;
    default:
      return Icons.payment_outlined;
  }
}
