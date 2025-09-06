import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class TransferButton extends StatefulWidget {
  const TransferButton({super.key});

  @override
  State<TransferButton> createState() => _TransferButtonState();
}

class _TransferButtonState extends State<TransferButton> {
  late final Debouncer _debouncer;
  late final TransferCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<TransferCubit>();

    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onComFirm() async {
      final result = await context.push<bool?>(AppRoutes.confirmationDialog);

      if (result != null && result && context.mounted) {
        _debouncer.run(context.read<TransferCubit>().onSubmit);
      }
    }

    void onValidate() async {
      _debouncer.run(context.read<TransferCubit>().onValidateBank);
    }

    final isLoading = context.select(
      (TransferCubit cubit) => cubit.state.status.isLoading,
    );
    final isInitial = context.select(
      (TransferCubit cubit) => cubit.state.status.isInitial,
    );
    final bankDetail = context.select(
      (TransferCubit cubit) => cubit.state.bankDetail,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: !isInitial && bankDetail != null
          ? AppStrings.transfer
          : AppStrings.validate,
      onPressed: isInitial && bankDetail == null ? onValidate : onComFirm,
    );
  }
}
