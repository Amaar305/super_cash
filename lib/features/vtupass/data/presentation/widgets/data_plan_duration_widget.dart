import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/vtupass/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataPlanDurationWidget extends StatelessWidget {
  const DataPlanDurationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (DataCubit cubit) => cubit.state.status.isLoading,
    );
    final selectedDuration = context.select(
      (DataCubit cubit) => cubit.state.selectedDuration,
    );

    final plans = context.select((DataCubit cubit) => cubit.state.dataPlans);

    if (plans.isEmpty) return SizedBox.shrink();

    return DurationTabItem(
      isLoading: isLoading,
      selectedDuration: selectedDuration,
      onChanged: context.read<DataCubit>().onDurationChanged,
      datatypes: ['All', 'Daily', 'Weekly', 'Monthly'],
    );
  }
}

class DurationTabItem extends StatelessWidget {
  const DurationTabItem({
    super.key,
    required this.selectedDuration,
    required this.onChanged,
    required this.datatypes,
    this.isLoading = false,
  });

  final String? selectedDuration;
  final void Function(String duration) onChanged;
  final List<String> datatypes;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectDurationType,
          style: poppinsTextStyle(
            fontSize: 10,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Wrap(
                  spacing: AppSpacing.md,
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(
                    datatypes.length,
                    (index) => _buildDataTypeItem(index),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDataTypeItem(int index) {
    var borderRadius2 = const BorderRadius.all(Radius.circular(8.8));
    final duration = datatypes[index];
    final selected = duration.toLowerCase() == selectedDuration;
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: !selected ? AppColors.transparent : AppColors.buttonColor,
        borderRadius: borderRadius2,
        border: Border.all(),
      ),
      child: Material(
        borderRadius: borderRadius2.subtract(
          const BorderRadius.all(Radius.circular(1)),
        ),
        color: selected ? AppColors.transparent : AppColors.white,
        child: InkWell(
          borderRadius: borderRadius2,
          onTap: isLoading ? null : () => onChanged(duration.toLowerCase()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            width: 68,
            height: 30,
            child: FittedBox(
              child: Text(
                datatypes[index],
                style: MonaSansTextStyle.label(
                  color: selected ? AppColors.white : null,
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
