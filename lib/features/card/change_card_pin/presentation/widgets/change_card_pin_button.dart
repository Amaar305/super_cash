import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class ChangeCardPinButton extends StatefulWidget {
  const ChangeCardPinButton({super.key});

  @override
  State<ChangeCardPinButton> createState() => _ChangeCardPinButtonState();
}

class _ChangeCardPinButtonState extends State<ChangeCardPinButton> {
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeCardPinCubit, ChangeCardPinState>(
      builder: (context, state) {
        final cubit = context.read<ChangeCardPinCubit>();

        return PrimaryButton(
          label: AppStrings.done,
          isLoading: state.status.isLoading,
          onPressed: () => _showConfirmationDialog(context, cubit),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, ChangeCardPinCubit cubit) {
    context.showExtraBottomSheet(
      title: AppStrings.changeCardPin,
      description: 'Are you sure you want to change card pin?',
      icon: Assets.images.info.image(),
      children: [
        PrimaryButton(
          label: AppStrings.yesContinue,
          onPressed: () => _debouncer.run(() {
            Navigator.pop(context);
            cubit.onCardPinChanged(
              onSuccess: (_) => _showSuccessDialog(context),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: AppOutlinedButton(
            isLoading: false,
            label: AppStrings.cancel,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    context.showConfirmationBottomSheet(
      title: 'Card Pin',
      okText: AppStrings.done,
      description: 'Your card pin has been changed successfully.',
    );
  }
}
