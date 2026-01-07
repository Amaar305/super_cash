import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

import '../../data.dart';

part 'data_state.dart';
part 'data_cubit.g.dart';

class DataCubit extends Cubit<DataState> {
  final FetchDataPlanUseCase _fetchDataPlanUseCase;
  final BuyDataPlanUseCase _buyDataPlanUseCase;
  DataCubit({
    required FetchDataPlanUseCase fetchDataPlanUseCase,
    required BuyDataPlanUseCase buyDataPlanUseCase,
  }) : _buyDataPlanUseCase = buyDataPlanUseCase,
       _fetchDataPlanUseCase = fetchDataPlanUseCase,
       super(DataState.initial());

  void resetState() => emit(DataState.initial());

  void onToggleShowPassword(bool instantData) {
    if (state.instantData == instantData) return;
    emit(state.copyWith(instantData: instantData));
  }

  void onFetchPlans({required String network}) async {
    if (isClosed) return;
    emit(state.copyWith(status: DataStatus.loading));

    try {
      final res = await _fetchDataPlanUseCase(
        FetchDataPlanParam(network: network),
      );
      if (isClosed) return;
      res.fold(
        (l) => emit(
          state.copyWith(status: DataStatus.failure, message: l.message),
        ),
        (r) {
          emit(
            state.copyWith(
              dataPlans: r.plans,
              status: DataStatus.success,
              selectedNetwork: network,
            ),
          );
        },
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          status: DataStatus.failure,
          message: "Fail to fetch data plans.",
        ),
      );
    }
  }

  void onNetworkChanged(String network) async {
    if (state.selectedNetwork == network || isClosed) return;

    final newState = state.resetChanges();

    emit(
      newState.copyWith(status: DataStatus.loading, selectedNetwork: network),
    );
    final res = await _fetchDataPlanUseCase(
      FetchDataPlanParam(network: network),
    );

    res.fold(
      (l) {
        if (isClosed) return;

        emit(state.copyWith(status: DataStatus.failure, message: l.message));
      },
      (r) {
        if (isClosed) return;

        emit(
          state.copyWith(
            dataPlans: r.plans,
            status: DataStatus.success,
            selectedNetwork: network,
            selectedDataType: r.plans.firstOrNull?.planType,
            selectedIndex: null,
          ),
        );
      },
    );
  }

  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.phone;
    final shouldValidate = previousPhoneState.invalid;

    final newPhoneState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = previousScreenState.copyWith(phone: newPhoneState);
    emit(newScreenState);
  }

  void onPhoneFocused() {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.phone;
    final previousPhoneValue = previousPhoneState.value;

    final newPhoneState = Phone.dirty(previousPhoneValue);

    final newScreenState = previousScreenState.copyWith(phone: newPhoneState);

    emit(newScreenState);
  }

  void onDataTypeChanged(String? dataType) {
    if (dataType == null) return;
    if (state.selectedDataType?.toLowerCase() == dataType.toLowerCase()) {
      return;
    }
    final newState = DataState(
      message: state.message,
      phone: state.phone,
      selectedNetwork: state.selectedNetwork,
      status: state.status,
      dataPlans: state.dataPlans,
      selectedDataType: dataType,
      selectedIndex: null,
      instantData: state.instantData,
      selectedDuration: state.selectedDuration,
    );
    emit(newState);
  }

  void onPlanSelected(int index) {
    if (state.selectedIndex == index) return;

    emit(state.copyWith(selectedIndex: index));
  }

  void onDurationChanged(String? duration) {
    if (duration == null) return;
    if (state.selectedDuration?.toLowerCase() == duration.toLowerCase()) {
      return;
    }

    final newState = DataState(
      message: state.message,
      phone: state.phone,
      selectedNetwork: state.selectedNetwork,
      status: state.status,
      dataPlans: state.dataPlans,
      selectedDataType: state.selectedDataType,
      selectedIndex: null,
      instantData: state.instantData,
      selectedDuration: duration.toLowerCase(),
    );
    emit(newState);
  }

  void onBuyData([void Function(TransactionResponse)? onSuccess]) async {
    final network = state.selectedNetwork;
    final selectedIndex = state.selectedIndex;
    final phone = Phone.dirty(state.phone.value);
    final isFormValid = FormzValid([phone]).isFormValid;

    final phoneNumber = state.phone.value;

    if (network == null || selectedIndex == null || !isFormValid) return;

    final newState = state.copyWith(
      phone: phone,
      selectedNetwork: network,
      selectedIndex: selectedIndex,
      status: isFormValid ? DataStatus.loading : null,
    );

    emit(newState);

    final planId = state.dataPlans[selectedIndex].id;
    final res = await _buyDataPlanUseCase(
      BuyDataPlanParam(
        network: network,
        planId: planId,
        phoneNumber: phoneNumber,
      ),
    );

    res.fold(
      (l) =>
          emit(state.copyWith(status: DataStatus.failure, message: l.message)),
      (r) {
        emit(state.copyWith(status: DataStatus.purchased));

        onSuccess?.call(r);
      },
    );
  }
}
