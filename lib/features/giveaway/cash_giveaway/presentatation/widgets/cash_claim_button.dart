import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashClaimButton extends StatelessWidget {
  const CashClaimButton({
    super.key,
    required this.onPressed,
    this.isAvailable = true,
    required this.quantityRemaining,
  });
  final VoidCallback onPressed;
  final bool isAvailable;
  final int quantityRemaining;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CashGiveawayCubit c) => c.state.status.isLoading,
    );
    final isPurchasable = quantityRemaining > 0 || !isAvailable;
    return PrimaryButton(
      isLoading: isLoading,
      label: !isAvailable
          ? 'Not Available'
          : !isPurchasable
          ? 'Claimed'
          : 'Claim Now',
      onPressed: !isAvailable
          ? null
          : !isPurchasable
          ? () {}
          : onPressed,
      fontColor: !isPurchasable ? null : AppColors.black,
    );
  }
}
