import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class RegisterType extends StatelessWidget {
  const RegisterType({super.key});

  @override
  Widget build(BuildContext context) {
    final basicSignup = context.select(
      (RegisterCubit cubit) => cubit.state.basicSignup,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: AppTab(
        children: [
          AppTabItem(
            label: 'Basic Sign up',
            activeTab: basicSignup,
            onTap: () => context.read<RegisterCubit>().changeType(true),
          ),
          AppTabItem(
            label: 'Google Sign up',
            activeTab: !basicSignup,
            onTap: () => context.read<RegisterCubit>().changeType(false),
          ),
        ],
      ),
    );
  }
}
