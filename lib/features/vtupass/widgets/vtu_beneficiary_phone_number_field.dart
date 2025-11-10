import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/vtupass/widgets/for_my_self_button.dart';
import 'package:flutter/material.dart';

class VtuBeneficiaryPhoneNumberField extends StatelessWidget {
  const VtuBeneficiaryPhoneNumberField({
    super.key,
    this.onChanged,
    this.phoneErrorMessage,
    this.onForMyselfTapped,
    this.textController,
    this.focusNode,
    this.isLoading = false,
  });
  final void Function(String value)? onChanged;
  final String? phoneErrorMessage;
  final VoidCallback? onForMyselfTapped;
  final bool isLoading;
  final TextEditingController? textController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    // textController?.text = value ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.enterBeneficiaryPhoneNumber,
          style: poppinsTextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
        AppTextField.underlineBorder(
          hintText: "Enter ${AppStrings.phoneNumber.toLowerCase()}",
          prefixIcon: Icon(
            Icons.phone_outlined,
            size: AppSpacing.xlg,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: focusNode,
          enabled: !isLoading,
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          textController: textController,
          suffixIcon: ForMySelfButton(onTap: onForMyselfTapped),
          onChanged: onChanged,
          errorText: phoneErrorMessage,
        ),
      ],
    );
  }
}
