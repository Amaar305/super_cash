import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/common.dart';

class VirtualCardTypeTab extends StatefulWidget {
  const VirtualCardTypeTab({super.key, this.isUSD = true, this.onChanged});

  @override
  State<VirtualCardTypeTab> createState() => _VirtualCardTypeTabState();
  final bool isUSD;
  final void Function(bool)? onChanged;
}

class _VirtualCardTypeTabState extends State<VirtualCardTypeTab> {
  @override
  Widget build(BuildContext context) {
    return AppTab(
      children: [
        AppTabItem(
          label: 'USD CARD',
          activeTab: widget.isUSD,
          onTap: () => widget.onChanged?.call(true),
        ),
        AppTabItem(
          label: 'NAIRA CARD',
          activeTab: !widget.isUSD,
          // onTap: () => widget.onChanged?.call(false),
          onTap: () => openSnackbar(
            SnackbarMessage.loading(
              title: 'Coming soon',
              // timeout: Duration(milliseconds: 100),
            ),
            clearIfQueue: true,
          ),
        ),
      ],
    );
  }
}
