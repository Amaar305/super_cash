import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/domain/entities/entities.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/presentation/presentation.dart';
import 'package:super_cash/features/vtupass/widgets/app_network_provider_widget.dart';

class SaveBeneficiaryNetworkProvider extends StatelessWidget {
  const SaveBeneficiaryNetworkProvider({super.key, required this.beneficiary});

  final Beneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    final selectedNetwork = context.select(
      (SaveUpdateBeneficiaryCubit cubit) =>
          beneficiary?.network ?? cubit.state.network,
    );
    final isLoading = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.status.isLoading,
    );
    final networkErrorMsg = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.networkErrorMsg,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        AppNetworkProviderWidget(
          onNetworkSelect: isLoading
              ? null
              : context.read<SaveUpdateBeneficiaryCubit>().onNetworkChanged,
          selectedNetwork: selectedNetwork,
        ),
        if (networkErrorMsg != null && networkErrorMsg.isNotEmpty)
          Text(
            networkErrorMsg,
            style: context.bodySmall?.copyWith(color: AppColors.red),
          ),
      ],
    );
  }
}
