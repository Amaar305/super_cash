import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class SubmitKycButton extends StatefulWidget {
  const SubmitKycButton({super.key});

  @override
  State<SubmitKycButton> createState() => _SubmitKycButtonState();
}

class _SubmitKycButtonState extends State<SubmitKycButton> {
  late final Debouncer _debouncer;
  late final UpgradeTierCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isloading = context.select(
      (UpgradeTierCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isloading,
      label: AppStrings.submitForReview,
      onPressed: () => _debouncer.run(
        () => _cubit.onSubmit(
          onSuccess: (p0) {
            context.showExtraBottomSheet(
              title: 'Account upgrade in progress',
              description: 'Confirm if it went successfull.',
              children: [
                BlocProvider.value(
                  value: _cubit,
                  child: CheckAccountUpgradeButton(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        isLoading: false,
                        label: AppStrings.cancel,
                        onPressed: context.pop,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CheckAccountUpgradeButton extends StatelessWidget {
  const CheckAccountUpgradeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isloading = context.select(
      (UpgradeTierCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      label: 'Check',
      isLoading: isloading,
      onPressed: context.read<UpgradeTierCubit>().onUpgradeConfirm,
    );
  }
}
