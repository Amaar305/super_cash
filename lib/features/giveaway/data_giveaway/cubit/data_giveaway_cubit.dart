import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'data_giveaway_state.dart';

class DataGiveawayCubit extends Cubit<DataGiveawayState> {
  final GetDataGiveawaysUseCase _getDataGiveawaysUseCase;
  final ClaimDataGiveawayUseCase _claimDataGiveawayUseCase;
  final String _giveawayTypeId;
  DataGiveawayCubit({
    required GetDataGiveawaysUseCase getDataGiveawaysUseCase,
    required ClaimDataGiveawayUseCase claimDataGiveawayUseCase,
    required AppUser user,
    required String giveawayTypeId,
  }) : _getDataGiveawaysUseCase = getDataGiveawaysUseCase,
       _claimDataGiveawayUseCase = claimDataGiveawayUseCase,
       _giveawayTypeId = giveawayTypeId,
       super(DataGiveawayState.initial(user));

  void onFilterNetworkChanged(int index) {
    if (state.selectedNetworkFilterIndex == index || state.status.isLoading) {
      return;
    }

    emit(state.copyWith(selectedNetworkFilterIndex: index));
  }

  Future<void> getPlans() async {
    try {
      emit(state.copyWith(status: DataGiveawayStatus.loading));

      final res = await _getDataGiveawaysUseCase(NoParam());
      res.fold(
        (l) => emit(
          state.copyWith(
            status: DataGiveawayStatus.failure,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: DataGiveawayStatus.loaded,
            dataPlans: r,
            message: '',
          ),
        ),
      );
    } catch (error, stackTrace) {
      logE('Failed to get data plans $error', stackTrace: stackTrace);
    }
  }

  /// [Phone] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = state.copyWith(phone: newSurnameState);

    emit(newScreenState);
  }

  void onPhoneUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Phone.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      phone: newUsernameState,
    );
    emit(newScreenState);
  }

  Future<void> claimData({
    required String dataId,
    required void Function(DataGiveawayItem giveaway) onClaimed,
  }) async {
    try {
      final phone = Phone.dirty(state.phone.value);
      final isFormValid = FormzValid([phone]).isFormValid;

      final newState = state.copyWith(
        phone: phone,
        status: !isFormValid ? null : DataGiveawayStatus.loading,
      );
      emit(newState);
      if (!isFormValid) return;

      final res = await _claimDataGiveawayUseCase(
        ClaimDataGiveawayParams(
          dataId: dataId,
          giveawayTypeId: _giveawayTypeId,
          phone: phone.value,
        ),
      );
      if (isClosed) return;

      res.fold(
        (failure) => emit(
          state.copyWith(
            status: DataGiveawayStatus.failure,
            message: failure.message,
          ),
        ),
        (success) {
          emit(state.copyWith(status: DataGiveawayStatus.claimed, message: ''));
          onClaimed(success);
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to claimed data giveaway $error', stackTrace: stackTrace);
    }
  }
}
