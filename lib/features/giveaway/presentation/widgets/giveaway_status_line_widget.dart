import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 234, 234),
          borderRadius: BorderRadius.circular(AppSpacing.md),
          border: Border.all(color: Color(0xFFC5C6D0).withValues(alpha: 0.20)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),

          child: Row(
            spacing: AppSpacing.xs,
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
      child: AnimatedContainer(
        duration: Durations.medium1,
        width: 112,
        height: 36,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: AppSpacing.xlg),
        decoration: BoxDecoration(
          color: selected ? Colors.white : null,
          borderRadius: !selected ? null : BorderRadius.circular(AppSpacing.sm),
        ),
        child: Text(
          status.name.capitalize,
          style: poppinsTextStyle(
            fontWeight: AppFontWeight.bold,
            fontSize: 12,
            color: !selected ? Color(0xFF44464F) : AppColors.black,
          ),
        ),
      ),
    );
  }
}
