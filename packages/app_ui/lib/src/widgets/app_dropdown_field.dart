// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
    required this.items,
    super.key,
    this.filled = false,
    this.enabled = true,
    this.onChanged,
    this.hintText,
    this.dropdownWidget,
    this.initialValue,
    this.focusNode,
    this.errorText,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
  });

  const AppDropdownField.underlineBorder({
    required List<String> items,
    Key? key,
    bool filled = false,
    String? hintText,
    String? initialValue,
    String? errorText,
    void Function(String?)? onChanged,
    Widget? dropdownWidget,
    bool enabled = true,
    FocusNode? focusNode,
    InputBorder? focusedBorder,
    InputBorder? enabledBorder,
    InputBorder? disabledBorder,
  }) : this(
          key: key,
          items: items,
          filled: filled,
          hintText: hintText,
          initialValue: initialValue,
          errorText: errorText,
          onChanged: onChanged,
          dropdownWidget: dropdownWidget,
          enabled: enabled,
          focusedBorder: focusedBorder,
          disabledBorder: disabledBorder,
          enabledBorder: enabledBorder ??
              const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.hinTextColor, width: 0.2),
              ),
          focusNode: focusNode,
          // border: const UnderlineInputBorder(
          //   borderSide:
          //       BorderSide(color: AppColors.lightBlueFilled, width: 0.05),
          // ),
        );

  final List<String> items;
  final bool filled;
  final String? hintText;
  final String? initialValue;
  final String? errorText;
  final void Function(String?)? onChanged;
  final Widget? dropdownWidget;
  final bool enabled;
  final FocusNode? focusNode;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? border;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items
          .toSet()
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      isExpanded: true,
      focusNode: focusNode,
      value: initialValue,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        border: border,
        enabledBorder: enabledBorder,
        disabledBorder: disabledBorder,
        focusedBorder: focusedBorder,
        enabled: enabled,
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: AppColors.hinTextColor,
          fontSize: 14,
        ),
        filled: filled,
        fillColor: context.customReversedAdaptiveColor(
          dark: AppColors.darkGrey,
          light: AppColors.lightBlueFilled,
        ),
      ),
    );
  }
}
