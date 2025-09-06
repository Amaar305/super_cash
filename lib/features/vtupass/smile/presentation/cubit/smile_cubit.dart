import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

part 'smile_state.dart';

class SmileCubit extends Cubit<SmileState> {
  SmileCubit() : super(SmileState.initial());

  void resetState() => emit(SmileState.initial());

  void onToggleType(bool isPhoneNumber) =>
      emit(state.copyWith(isPhoneNumber: isPhoneNumber));

  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.phone;
    final shouldValidate = previousPhoneState.invalid;

    final newPhoneState =
        shouldValidate ? Phone.dirty(newValue) : Phone.pure(newValue);

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

  void onSubmit([VoidCallback? onSuccess]) async {
    final phone = Phone.dirty(state.phone.value);
    final isFormValid = FormzValid([phone]).isFormValid;

    final newState = state.copyWith(
      phone: phone,
      status: isFormValid ? SmileStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      await Future.delayed(Duration(seconds: 5));
      emit(state.copyWith(status: SmileStatus.success));
      final newState = state.copyWith(status: SmileStatus.success);
      if (isClosed) return;
      emit(newState);
      onSuccess?.call();
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  void _errorFormatter(Object error, StackTrace stackTrace) {}
}
