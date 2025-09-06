import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/smile/presentation/presentation.dart';
import 'package:super_cash/features/vtupass/widgets/vtpass_type_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmileTab extends StatelessWidget {
  const SmileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isPhoneNumber = context.select(
      (SmileCubit cubit) => cubit.state.isPhoneNumber,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: VTPassTypeContainer(
        children: [
          VTPassTabItem(
            label: AppStrings.phoneNumber,
            activeTab: isPhoneNumber,
            onTap: () => context.read<SmileCubit>().onToggleType(true),
          ),
          VTPassTabItem(
            label: AppStrings.accountNumber,
            activeTab: !isPhoneNumber,
            onTap: () => context.read<SmileCubit>().onToggleType(false),
          ),
        ],
      ),
    );
  }
}
