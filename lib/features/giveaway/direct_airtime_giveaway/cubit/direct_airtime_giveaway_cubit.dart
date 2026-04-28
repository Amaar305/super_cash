import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'direct_airtime_giveaway_state.dart';

class DirectAirtimeGiveawayCubit extends Cubit<DirectAirtimeGiveawayState> {
  final AddDirectAirtimePhoneGiveawayUseCase
  _addDirectAirtimePhoneGiveawayUseCase;
  final GetDirectAirtimesGiveawayUseCase _getDirectAirtimesGiveawayUseCase;
  final ClaimDirectAirtimeGiveawayUseCase _claimDirectAirtimeGiveawayUseCase;
  final String _giveawayTypeId;
  DirectAirtimeGiveawayCubit({
    required AddDirectAirtimePhoneGiveawayUseCase
    addDirectAirtimePhoneGiveawayUseCase,
    required GetDirectAirtimesGiveawayUseCase getDirectAirtimesGiveawayUseCase,
    required ClaimDirectAirtimeGiveawayUseCase
    claimDirectAirtimeGiveawayUseCase,
    required String giveawayTypeid,
  }) : _addDirectAirtimePhoneGiveawayUseCase =
           addDirectAirtimePhoneGiveawayUseCase,
       _claimDirectAirtimeGiveawayUseCase = claimDirectAirtimeGiveawayUseCase,
       _getDirectAirtimesGiveawayUseCase = getDirectAirtimesGiveawayUseCase,
       _giveawayTypeId = giveawayTypeid,
       super(DirectAirtimeGiveawayState.initial());

  void onFilterNetworkChanged(int index) {
    if (state.selectedNetworkFilterIndex == index || state.status.isLoading) {
      return;
    }

    emit(state.copyWith(selectedNetworkFilterIndex: index));
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

  Future<void> getAirtimes() async {
    emit(state.copyWith(status: DirectAirtimeGiveawayStatus.loading));

    final res = await _getDirectAirtimesGiveawayUseCase(NoParam());

    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(
          status: DirectAirtimeGiveawayStatus.failure,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          airtimes: r,
          message: '',
          status: DirectAirtimeGiveawayStatus.loaded,
        ),
      ),
    );
  }

  Future<void> claimDirectAirtime(
    String airtimeId, {
    void Function(DirectAirtimeModel airtime)? onClaimed,
  }) async {
    emit(state.copyWith(status: DirectAirtimeGiveawayStatus.loading));

    final res = await _claimDirectAirtimeGiveawayUseCase(
      ClaimDirectAirtimeGiveawayParams(
        airtimeId: airtimeId,
        giveawayTypeId: _giveawayTypeId,
      ),
    );

    res.fold(
      (l) => emit(
        state.copyWith(
          status: DirectAirtimeGiveawayStatus.failure,
          message: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: DirectAirtimeGiveawayStatus.claimed,
            message: '',
            airtimes: state.airtimes.map((item) {
              if (item.id == r.id) return r;
              return item;
            }).toList(),
          ),
        );
        onClaimed?.call(r);
      },
    );
  }

  Future<void> addDirectAirtimePhone(
    String airtimeId, {
    required void Function(UserDirectAirtimePhoneModel phone) onAdded,
  }) async {
    final phone = Phone.dirty(state.phone.value);
    final isFormValid = FormzValid([phone]).isFormValid;
    final newState = state.copyWith(
      phone: phone,
      status: !isFormValid ? null : DirectAirtimeGiveawayStatus.loading,
    );

    emit(newState);
    if (!isFormValid) return;

    final res = await _addDirectAirtimePhoneGiveawayUseCase(
      AddDirectAirtimePhoneGiveawayParams(
        airtimeId: airtimeId,
        phoneNumber: phone.value,
      ),
    );

    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(
          status: DirectAirtimeGiveawayStatus.failure,
          message: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: DirectAirtimeGiveawayStatus.submited,
            message: '',
          ),
        );
        onAdded(r);
      },
    );
  }
}
