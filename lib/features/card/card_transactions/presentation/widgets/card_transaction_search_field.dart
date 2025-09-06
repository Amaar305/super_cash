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
    return Row(
      spacing: AppSpacing.md,
      children: [
        Expanded(
          child: AppTextField(
            hintText: AppStrings.search,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.15),
              borderSide: BorderSide(
                color: AppColors.lightBlueFilled,
                width: 1.23,
              ),
            ),
            onChanged: (value) =>
                _debouncer.run(() => _cubit.searchTransaction(value)),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(Icons.search, color: AppColors.white, size: 22),
        ),
      ],
    );
  }
}
