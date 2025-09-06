import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import '../../change_card_pin.dart';

part 'change_card_pin_state.dart';

class ChangeCardPinCubit extends Cubit<ChangeCardPinState> {
  final String _cardId;
  final ChangeCardPinUseCase _changeCardPinUseCase;
  ChangeCardPinCubit({
    required String cardId,
    required ChangeCardPinUseCase changeCardPinUseCase,
  })  : _cardId = cardId,
        _changeCardPinUseCase = changeCardPinUseCase,
        super(ChangeCardPinState.initial());

  void resetState() => emit(ChangeCardPinState.initial());

  void onNewCardPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.newCardPin;
    final shouldValidate = previousPinState.invalid;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState =
        previousScreenState.copyWith(newCardPin: newPinState);

    emit(newScreenState);
  }

  void onConfirmPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.confirmCardPin;
    final shouldValidate = previousPinState.invalid;

    final didMatched = value == previousScreenState.newCardPin.value;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(
        confirmCardPin: newPinState,
        confirmCardPinMessage: !didMatched ? 'Pin does not match' : '');

    emit(newScreenState);
  }

  void onCardPinChanged({
    void Function(Map<String, dynamic>)? onSuccess,
  }) async {
    emit(
      state.copyWith(
        status: ChangeCardPinStatus.loading,
      ),
    );
    final newCardPin = Otp.dirty(state.newCardPin.value);
    final confirmCardPin = Otp.dirty(state.confirmCardPin.value);
    final didMatched = newCardPin.value == confirmCardPin.value;
    final isFormValid =
        FormzValid([newCardPin, confirmCardPin]).isFormValid && didMatched;

    final newState = state.copyWith(
      newCardPin: newCardPin,
      confirmCardPin: confirmCardPin,
      status: isFormValid ? ChangeCardPinStatus.loading : null,
    );

    emit(newState);
    if (!isFormValid || isClosed) return;

    try {
      final res = await _changeCardPinUseCase(
        ChangeCardParams(
          pin: newCardPin.value,
          cardId: _cardId,
        ),
      );

      res.fold(
        (l) => emit(state.copyWith(
            status: ChangeCardPinStatus.failure, message: l.message)),
        (r) {
          emit(
            state.copyWith(
              status: ChangeCardPinStatus.pinChanged,
            ),
          );

          onSuccess?.call(r);
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChangeCardPinStatus.failure,
          message: 'Something weent wrong.',
        ),
      );
    }
  }
}
