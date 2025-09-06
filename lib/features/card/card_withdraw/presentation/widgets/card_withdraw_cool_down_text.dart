import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cooldown/cooldown.dart';

class CardWithdrawCoolDownText extends StatelessWidget {
  const CardWithdrawCoolDownText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Text(
          'You can withdraw your card after:',
          style: TextStyle(
            fontSize: AppSpacing.md - 1,
            color: Color.fromRGBO(52, 52, 52, 1),
          ),
        ),
        BlocBuilder<CooldownCubit, CooldownState>(
          builder: (context, state) {
            final cooldowns = state.cooldowns;
            final remaining = cooldowns[CooldownKeys.withdrawCard];
            var style = TextStyle(
              fontSize: AppSpacing.lg,
              fontWeight: AppFontWeight.medium,
            );
            if (remaining != null) {
              final minutes = remaining.inMinutes;
              final seconds = remaining.inSeconds % 60;

              return Text("$minutes:${seconds.toString().padLeft(2, '0')}");
            }
            return Text(
              '00:00',
              style: style,
            );
          },
        ),
      ],
    );
  }
}
