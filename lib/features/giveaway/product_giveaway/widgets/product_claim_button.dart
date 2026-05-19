import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProductClaimButton extends StatelessWidget {
  const ProductClaimButton({
    super.key,
    this.isDisabled = false,
    this.label,
    required this.onClaimed,
    required this.isLoading,
  });
  final bool isDisabled;
  final bool isLoading;
  final String? label;

  final VoidCallback onClaimed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      isLoading: isLoading,
      onPressed: isDisabled ? null : onClaimed,
      label: label ?? (isDisabled ? 'Out of stock' : 'Claim Now'),
    );
  }
}
