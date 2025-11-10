import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AppDropdownSearchField extends StatefulWidget {
  const AppDropdownSearchField({
    super.key,
    required this.label,
    this.hint,
    required this.items,
    this.hasError = false,
    this.onChange,
    this.enable = true,
    this.initialValue,
  });
  final String label;
  final String? hint;
  final List<String>? items;
  final bool hasError;
  final String? initialValue;
  final bool enable;
  final void Function(String? value)? onChange;

  @override
  State<AppDropdownSearchField> createState() => _AppDropdownSearchFieldState();
}

class _AppDropdownSearchFieldState extends State<AppDropdownSearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(widget.label, style: const TextStyle(fontSize: 12)),
          ),
          DropdownSearch<String>(
            items: widget.items != null ? (f, cs) => widget.items! : null,
            enabled: widget.enable,
            selectedItem: widget.initialValue,
            popupProps: const PopupProps.menu(
              // disabledItemFn: (item) => item == 'Item 3',
              fit: FlexFit.loose,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Type to search",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Color(0xCCADABAB)),
                border: const UnderlineInputBorder(),
                enabled: widget.enable,
              ),
            ),
            onChanged: widget.onChange,
          ),
        ],
      ),
    );
  }
}
