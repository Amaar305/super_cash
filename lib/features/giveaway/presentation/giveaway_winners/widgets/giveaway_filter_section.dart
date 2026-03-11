import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayFilterSection extends StatelessWidget {
  const GiveawayFilterSection({super.key, required this.types, this.onChanged});

  final List<String> types;
  final void Function(String label)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: List.generate(types.length, (index) {
            var text = types[index];
            final selected = context.select(
              (GiveawayWinnersCubit element) => element.state.filter == text,
            );
            return GiveawayFilterChip(
              label: text,
              selected: selected,
              onChanged: onChanged,
            );
          }),
        ),
      ),
    );
  }
}
