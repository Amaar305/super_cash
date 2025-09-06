import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/widgets/app_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class ForgotPasswordType extends StatelessWidget {
  const ForgotPasswordType({super.key});

  @override
  Widget build(BuildContext context) {
    final withEmail = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.withEmail,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: AppTab(
        children: [
          AppTabItem(
            label: 'With Email',
            activeTab: withEmail,
            onTap: () => context.read<ForgotPasswordCubit>().changeType(true),
          ),
          AppTabItem(
            label: 'With Phone',
            activeTab: !withEmail,
            onTap: () => context.read<ForgotPasswordCubit>().changeType(false),
          ),
        ],
      ),
    );
  }
}
