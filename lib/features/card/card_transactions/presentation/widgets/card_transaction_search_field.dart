import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class CardTransactionSearchField extends StatefulWidget {
  const CardTransactionSearchField({super.key});

  @override
  State<CardTransactionSearchField> createState() =>
      _CardTransactionSearchFieldState();
}

class _CardTransactionSearchFieldState
    extends State<CardTransactionSearchField> {
  late final CardTransactionsCubit _cubit;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CardTransactionsCubit>();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSortAsc = context.select(
      (CardTransactionsCubit cubit) => cubit.state.isSortAsc,
    );

    return Row(
      spacing: AppSpacing.sm,
      children: [
        Expanded(
          child: AppTextField(
            hintText: AppStrings.search,
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.brightGrey),
            ),
            onChanged: (value) =>
                _debouncer.run(() => _cubit.searchTransaction(value)),
          ),
        ),
        Tappable.faded(
          onTap: _cubit.sortByAmount,
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.brightGrey),
            ),
            child: Icon(
              isSortAsc ? Icons.arrow_upward : Icons.arrow_downward,
              size: 18,
              color: AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
