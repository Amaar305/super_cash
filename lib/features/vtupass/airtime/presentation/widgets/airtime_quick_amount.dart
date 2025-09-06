import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../airtime.dart';

class AirtimeQuickAmount extends StatefulWidget {
  const AirtimeQuickAmount({
    super.key,
  });

  @override
  State<AirtimeQuickAmount> createState() => _AirtimeQuickAmountState();
}

class _AirtimeQuickAmountState extends State<AirtimeQuickAmount> {
  late final AirtimeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AirtimeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((AirtimeCubit cubit) => cubit.state.status.isLoading);
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amount to Select',
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        QuickAmount(
          enabled: !isLoading,
          onChanged: (value) => _cubit.onAmountChanged(value),
        ),
      ],
    );
  }
}
