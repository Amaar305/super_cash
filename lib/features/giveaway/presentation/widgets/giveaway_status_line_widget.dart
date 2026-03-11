import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayStatusLineWidget extends StatelessWidget {
  const GiveawayStatusLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final st = List<UpcomingGiveawayStatus>.from(UpcomingGiveawayStatus.values)
      ..removeWhere((element) => element == UpcomingGiveawayStatus.upcoming);

    final selectedStatus = context.select(
      (GiveawayCubit cubit) => cubit.state.selectedStatus,
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),

        child: Row(
          spacing: 26,
          children: st.map((status) {
            final selected = status == selectedStatus;
            return _StatusChip(
              selected: selected,
              status: status,
              onTap: context.read<GiveawayCubit>().filterbyStatus,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.selected, this.onTap, required this.status});

  final bool selected;
  final void Function(UpcomingGiveawayStatus status)? onTap;
  final UpcomingGiveawayStatus status;

  @override
  Widget build(BuildContext context) {
    return Tappable.scaled(
      onTap: () => onTap?.call(status),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            status.name.capitalize,
            style: poppinsTextStyle(fontWeight: AppFontWeight.medium),
          ),
          AnimatedContainer(
            duration: 200.ms,
            curve: Curves.easeInOut,
            width: 65,
            height: 3,
            color: selected ? AppColors.primary2 : AppColors.brightGrey,
          ),
        ],
      ),
    );
  }
}
