import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class CardTransactionFilterDialog extends StatelessWidget {
  const CardTransactionFilterDialog({super.key});
  final List<FilterPeriod> filterPeriods = const [
    FilterPeriod(label: 'Today', type: FilterPeriodType.today),
    FilterPeriod(label: 'This week', type: FilterPeriodType.week),
    FilterPeriod(label: 'This month', type: FilterPeriodType.month),
    FilterPeriod(label: 'Previous month', type: FilterPeriodType.prevMonth),
    FilterPeriod(label: 'This year', type: FilterPeriodType.year),
  ];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog.adaptive(
          contentPadding: EdgeInsets.all(AppSpacing.lg).copyWith(top: 0),
          titlePadding: EdgeInsets.all(AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.xxlg / 2),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.filter,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Tappable.faded(
                    onTap: () {},
                    child: Text(
                      AppStrings.clear,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Color(0xFF2463FF),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.period,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Wrap(
                spacing: AppSpacing.sm,
                children: filterPeriods
                    .map((e) => newMethod(e, context))
                    .toList(),
              ),
              Gap.v(AppSpacing.sm),
              Text(
                AppStrings.selectPeriod,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          actions: [
            PrimaryButton(label: AppStrings.showResults, onPressed: () {}),
          ],
        );
      },
    );
  }

  FilterChip newMethod(FilterPeriod e, BuildContext context) {
    return FilterChip.elevated(
      key: ValueKey(e.label),
      selected: e.type.isThisWeek,
      selectedColor: Color.fromRGBO(36, 99, 255, 0.3),
      label: Text(e.label, style: Theme.of(context).textTheme.labelSmall),
      onSelected: (value) {},
    );
  }
}

enum FilterPeriodType {
  today,
  week,
  month,
  year,
  prevMonth;

  bool get isToday => this == FilterPeriodType.today;
  bool get isThisWeek => this == FilterPeriodType.week;
  bool get isThisMonth => this == FilterPeriodType.month;
  bool get isThisYear => this == FilterPeriodType.year;
  bool get isPreviousMonth => this == FilterPeriodType.prevMonth;
}

class FilterPeriod {
  final String label;
  final FilterPeriodType type;

  const FilterPeriod({required this.label, required this.type});

  FilterPeriod copyWith({String? label, FilterPeriodType? type}) {
    return FilterPeriod(label: label ?? this.label, type: type ?? this.type);
  }
}
