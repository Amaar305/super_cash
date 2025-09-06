import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class DataViewSwitcher extends StatelessWidget {
  const DataViewSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final instantData = context.select(
      (DataCubit cubit) => cubit.state.instantData,
    );
    return BlocListener<DataCubit, DataState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: AnimatedCrossFade(
        firstChild: DataInstant(),
        secondChild: DataScheduled(),
        crossFadeState: instantData
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: 100.ms,
      ),
    );
  }
}
