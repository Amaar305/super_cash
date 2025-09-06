import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../vtupass.dart';

class AirtimeNetworkProviders extends StatelessWidget {
  const AirtimeNetworkProviders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedNetwork =
        context.select((AirtimeCubit cubit) => cubit.state.selectedNetwork);
    //TODO: If network is very strong we indicate that also we indicate poor network aswell

    return AppNetworkProviderWidget(
      selectedNetwork: selectedNetwork,
      onNetworkSelect: (network) =>
          context.read<AirtimeCubit>().onNetworkChanged(network),
    );
  }
}
