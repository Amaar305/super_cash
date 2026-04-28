import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashClaimButton extends StatelessWidget {
  const CashClaimButton({
    super.key,
    required this.onPressed,
    this.isAvailable = true,
  });
  final VoidCallback onPressed;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CashGiveawayCubit c) => c.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: !isAvailable ? 'Not Available' : 'Claim Now',
      onPressed: !isAvailable ? null : onPressed,
    );
  }
}
