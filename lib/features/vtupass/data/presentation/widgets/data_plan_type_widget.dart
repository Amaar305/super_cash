import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../data.dart';

class DataPlanTypeWidget extends StatelessWidget {
  const DataPlanTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredDataTypes = context.select(
      (DataCubit cubit) => cubit.state.filteredDataTypes,
    );

    final selectedDataType = context.select(
      (DataCubit cubit) => cubit.state.selectedDataType,
    );

    final isLoading = context.select(
      (DataCubit cubit) => cubit.state.status.isLoading,
    );

    if (filteredDataTypes.isEmpty) {
      return SizedBox.shrink();
    }

    return LinePlanType(
      isLoading: isLoading,
      selectedDataType: selectedDataType,
      onChanged: context.read<DataCubit>().onDataTypeChanged,
      datatypes: filteredDataTypes,
    );
  }
}

class LinePlanType extends StatelessWidget {
  const LinePlanType({
    super.key,
    this.selectedDataType,
    required this.onChanged,
    required this.datatypes,
    required this.isLoading,
  });

  final String? selectedDataType;
  final void Function(String? dataType) onChanged;
  final List<String> datatypes;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectDataType,
          style: poppinsTextStyle(
            fontSize: 10,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(datatypes.length, (index) {
              final planType = datatypes[index];
              final selected = planType == selectedDataType;
              return Tappable.scaled(
                onTap: isLoading ? null : () => onChanged(planType),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      datatypes[index]
                          .toLowerCase()
                          .replaceAll('airtel', '')
                          .replaceAll('mtn', ' ')
                          .toUpperCase(),
                      style: poppinsTextStyle(fontWeight: AppFontWeight.medium),
                    ),
                    AnimatedContainer(
                      duration: 200.ms,
                      width: 65,
                      height: 3,
                      color: selected
                          ? AppColors.primary2
                          : AppColors.brightGrey,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
