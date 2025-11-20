import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../data.dart';

class DataPlansSection extends StatelessWidget {
  const DataPlansSection({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = context.select(
      (DataCubit cubit) => cubit.state.filteredPlans,
    );
    final isLoading = context.select(
      (DataCubit cubit) => cubit.state.status.isLoading,
    );
    final selectedIndex = context.select(
      (DataCubit cubit) => cubit.state.selectedIndex,
    );

    if (plans.isEmpty) {
      return const AppEmptyState(
        title: 'No data plans available',
        description: 'Kindly try a different network or refresh to continue.',
        icon: Icons.signal_cellular_nodata_outlined,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text(
          AppStrings.selectPlan,
          style: poppinsTextStyle(
            fontSize: 10,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: plans.length,
          itemBuilder: (context, index) => _buildListvVewPlanItem(
            isLoading: isLoading,
            plans: plans[index],
            index: index,
            selectedIndex: selectedIndex,
            onPlanSelected: () =>
                context.read<DataCubit>().onPlanSelected(index),
          ),
        ),
      ],
    );
  }

  Widget buildPlanItem({
    required DataPlan plans,
    required bool isLoading,
    required int index,
    int? selectedIndex,
    required VoidCallback onPlanSelected,
  }) {
    return Tappable.scaled(
      onTap: isLoading ? null : onPlanSelected,
      child: GridTile(
        footer: Container(
          width: double.infinity,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.xs),
              topRight: Radius.circular(AppSpacing.xs),
            ),
          ),
          child: Text(
            plans.planValidity,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ),
        child: AnimatedContainer(
          duration: 200.ms,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.blue.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            border: selectedIndex == index ? Border.all(width: 0.4) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.sm,
            children: [
              Text(
                plans.planName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: AppFontWeight.medium,
                  fontSize: 13,
                ),
              ),
              Text('MTN ${plans.planType}', style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListvVewPlanItem({
    required DataPlan plans,
    required bool isLoading,
    required int index,
    int? selectedIndex,
    required VoidCallback onPlanSelected,
  }) {
    final selected = selectedIndex == index;

    return Tappable.faded(
      onTap: isLoading ? null : onPlanSelected,
      child: AnimatedContainer(
        duration: 200.ms,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: !selected
              ? AppColors.white
              : AppColors.primary2.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.2),
        ),
        child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.5),
            ),
            alignment: Alignment.center,
            child: Assets.images.cellular.image(
              width: AppSize.iconSizeSmall,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            plans.planName,
            style: poppinsTextStyle(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 12,
            ),
          ),
          subtitle: Text(
            'Duration: ${plans.planValidity}',
            style: poppinsTextStyle(
              color: AppColors.background.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
          trailing: Container(
            width: 70,
            height: 30,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.primary2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'N${plans.planAmount}',
                textAlign: TextAlign.center,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.white,
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
