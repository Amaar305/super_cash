import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class AppServiceProviderWidget extends StatelessWidget {
  const AppServiceProviderWidget({
    super.key,
    this.selectedService,
    this.onChanged,
    required this.services,
    required this.label,
    this.showText = false,
    this.isLoading = false,
  });

  final String? selectedService;
  final String label;
  final bool showText;
  final bool isLoading;
  final void Function(ServiceProviderModel cardProvider)? onChanged;
  final List<ServiceProviderModel> services;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(AppStrings.availableTvCable),
        const SizedBox(height: 6),
        Row(
          spacing: AppSpacing.md,
          children: services
              .map(
                (cable) => _buildItem(
                  cable: cable.name,
                  selectedCable: selectedService,
                  icon: cable.icon,
                  onPressed: () => _setSelectedIndex(cable),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildItem({
    required String cable,
    required Widget icon,
    String? selectedCable,
    required void Function() onPressed,
  }) {
    final isSelected = selectedCable == cable;

    return Expanded(
      child: Material(
        elevation: 2,
        shadowColor: Color(0x13005C58),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: AnimatedContainer(
            duration: 200.milliseconds,
            height: 78,
            alignment: Alignment(0, 0),
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: isSelected
                    ? const Color.fromRGBO(23, 27, 42, 1)
                    : AppColors.transparent,
              ),
            ),
            child: Column(
              spacing: AppSpacing.md,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 100, height: 30, child: icon),
                if (showText)
                  Text(
                    cable,
                    style: TextStyle(
                      fontSize: AppSpacing.sm + 2,
                      fontWeight: AppFontWeight.medium,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setSelectedIndex(ServiceProviderModel provider) {
    onChanged?.call(provider);
  }
}

class ServiceProviderModel {
  final String name;
  final Widget icon;
  final String? value;

  const ServiceProviderModel({
    required this.name,
    required this.icon,
    this.value,
  });
}
