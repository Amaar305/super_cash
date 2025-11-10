import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/core/helper/select_contacts.dart';
import 'package:flutter/material.dart';

import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/services.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/manage_beneficiary.dart';

class VTUActionButtons extends StatelessWidget {
  const VTUActionButtons({
    super.key,
    this.onNumberPasted,
    this.onContactPicked,
    this.onBeneficiaryTapped,
    this.isLoading = false,
  });

  final void Function(String value)? onNumberPasted;
  final void Function(String value)? onContactPicked;
  final void Function(Beneficiary? beneficiary)? onBeneficiaryTapped;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 10),
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(width: 0.4),
      //   boxShadow: [
      //     BoxShadow(
      //       color: AppColors.primary2.withValues(alpha: 0.08),
      //       offset: Offset(0, 2),
      //       blurRadius: 9,
      //       spreadRadius: 3,
      //     )
      //   ],
      // ),
      child: Row(
        spacing: AppSpacing.sm,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MiniButtonVTU(
              icon: Icons.person,
              label: AppStrings.beneficiary,
              onTap: isLoading ? null : () => _onBeneficiaryPicked(context),
            ),
          ),
          Expanded(
            child: MiniButtonVTU(
              label: AppStrings.paste,
              onTap: isLoading ? null : () => _onNumberPasted(context),
              icon: Icons.paste,
            ),
          ),
          Expanded(
            child: MiniButtonVTU(
              icon: Icons.contact_emergency_outlined,
              onTap: isLoading ? null : () => _onContactSelected(context),
              label: AppStrings.contact,
              useBorder: false,
            ),
          ),
        ],
      ),
    );
  }

  void _onNumberPasted(BuildContext context) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && context.mounted) {
      final nonDigit = RegExp("\\D");
      String phoneNumber = data!.text!;
      phoneNumber = phoneNumber.replaceAll(nonDigit, "");
      phoneNumber = phoneNumber.replaceFirst("234", "0");

      onNumberPasted?.call(phoneNumber);
    }
  }

  void _onContactSelected(BuildContext context) async {
    final selectedPhone = await pickContact(context);
    if (selectedPhone == null || !context.mounted) return;
    onContactPicked?.call(selectedPhone);
  }

  void _onBeneficiaryPicked(BuildContext context) async {
    final result = await showModalBottomSheet<Beneficiary?>(
      context: context,
      builder: (context) => ManageBeneficiaryPage(fromBeneficiary: true),
    );
    onBeneficiaryTapped?.call(result);
  }
}

class MiniButtonVTU extends StatelessWidget {
  const MiniButtonVTU({
    super.key,
    this.useBorder = true,
    required this.label,
    this.icon,
    this.onTap,
  });
  final bool useBorder;
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: AppButton.outlined(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // fixedSize: Size.fromHeight(30),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
        text: label,
        onPressed: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.md,
            children: [
              if (icon != null) Icon(icon, size: 17, color: AppColors.darkGrey),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: poppinsTextStyle(
                    fontSize: 12,
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.background,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
