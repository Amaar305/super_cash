// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared/shared.dart';

/// A widget that provides network-related functionalities.
///
/// The `AppNetworkProviderWidget` is a `StatelessWidget` that is used to handle
/// network operations and provide network-related functionalities to its
/// child widgets. This widget can be used to manage network states, handle
/// network errors, and provide a consistent network experience across the app.
///
/// Example usage:
/// ```dart
/// AppNetworkProviderWidget(
///   child: YourChildWidget(),
/// )
/// ```
///
/// The `AppNetworkProviderWidget` should be placed at a
/// higher level in the widget
/// tree to ensure that all descendant widgets can access the network
/// functionalities provided by this widget.
class AppNetworkProviderWidget extends StatelessWidget {
  const AppNetworkProviderWidget({
    super.key,
    this.selectedNetwork,
    this.onNetworkSelect,
    this.networks = const ['9Mobile', 'Glo', 'Airtel', 'MTN'],
  });

  final List<String> networks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Network Provider',
          style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          spacing: AppSpacing.lg,
          children: networks
              .map((network) => _buildNetworkItem(network, selectedNetwork))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildNetworkItem(String network, String? selectedNetwork) {
    final isSelected = selectedNetwork == network.toLowerCase();

    return Expanded(
      child: GestureDetector(
        onTap: () {
          onNetworkSelect?.call(network.toLowerCase());
        },
        child: AnimatedContainer(
          duration: 200.ms,
          height: 78,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              width: 0.4,
              color: isSelected ? AppColors.lightBlue : AppColors.white,
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getNetworkImage(network),
              const SizedBox(height: 4),
              Text(
                network,
                style: poppinsTextStyle(fontSize: AppSpacing.sm + 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNetworkImage(String network) {
    return switch (network.toLowerCase()) {
      'mtn' => Assets.images.mtn.image(width: 37, fit: BoxFit.contain),
      'airtel' => Assets.images.airtel.image(width: 37, fit: BoxFit.contain),
      '9mobile' => Assets.images.a9mobile.image(width: 37, fit: BoxFit.contain),
      'glo' => Assets.images.glo.image(width: 37, fit: BoxFit.contain),
      _ => Assets.images.mtn.image(width: 37, fit: BoxFit.contain),
    };
  }

  final String? selectedNetwork;
  final void Function(String network)? onNetworkSelect;
}
