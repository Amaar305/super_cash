import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import '../../domain/use_cases/create_card_use_cases.dart';

part 'create_virtual_card_state.dart';

class CreateVirtualCardCubit extends Cubit<CreateVirtualCardState> {
  final CreateCardUseCases _createCardUseCases;
  CreateVirtualCardCubit({
    required CreateCardUseCases createCardUseCases,
  })  : _createCardUseCases = createCardUseCases,
        super(CreateVirtualCardState.initial());

  void updateCardType(bool cardType) =>
      emit(state.copyWith(isUSDCard: cardType));
  void updateCardPlatinum(int index) {
    if (index == 0) {
      emit(state.copyWith(platinum: false));
    } else {
      emit(state.copyWith(platinum: true));
    }
  }

  void updateCardBrand(bool cardBrand) =>
      emit(state.copyWith(isMasterCard: cardBrand));

  void changePinVisibility() => emit(state.copyWith(showPin: !state.showPin));

  void onAmountChanged(String newValue) {
    final previousScreenState = state;
    final previoustAmountState = previousScreenState.amount;
    final shouldValidate = previoustAmountState.invalid;
    final commaOrSpace = RegExp(r'[, ]');

    final amountValue = newValue.replaceAll(commaOrSpace, "");
    final newAmountState =
        shouldValidate ? Amount.dirty(amountValue) : Amount.pure(amountValue);

    final newScreenState = previousScreenState.copyWith(amount: newAmountState);

    emit(newScreenState);
  }

  void onAmountFocused() {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amount;

    final previousAmountValue = previousAmountState.value;

    final newAmountState = Amount.dirty(previousAmountValue);

    final newScreenState = previousScreenState.copyWith(amount: newAmountState);

    emit(newScreenState);
  }

  void onCardPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.cardPin;
    final shouldValidate = previousPinState.invalid;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(cardPin: newPinState);

    emit(newScreenState);
  }

  void onConfirmPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.confirmCardPin;
    final shouldValidate = previousPinState.invalid;

    final didMatched = value == previousScreenState.cardPin.value;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(
        confirmCardPin: newPinState,
        confirmCardPinMessage: !didMatched ? 'Pin does not match' : '');

    emit(newScreenState);
  }

  void onProceed(VoidCallback? onProcessed) async {
    final amount = Amount.dirty(state.amount.value);
    final cardPin = Otp.dirty(state.cardPin.value);
    final confirmCardPin = Otp.dirty(state.confirmCardPin.value);
    final didMatched = cardPin.value == confirmCardPin.value;
    final isFormValid =
        FormzValid([amount, cardPin, confirmCardPin]).isFormValid && didMatched;

    final newState = state.copyWith(
      amount: amount,
      cardPin: cardPin,
      confirmCardPin: confirmCardPin,
      status: isFormValid ? CreateVirtualCardStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;
    try {
      emit(state.copyWith(status: CreateVirtualCardStatus.process));
      final newState = state.copyWith(status: CreateVirtualCardStatus.process);
      if (isClosed) return;
      emit(newState);
      onProcessed?.call();
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  void onSubmit([VoidCallback? onSubmit]) async {
    final amount = Amount.dirty(state.amount.value);
    final cardPin = Otp.dirty(state.cardPin.value);
    final confirmCardPin = Otp.dirty(state.confirmCardPin.value);
    final didMatched = cardPin.value == confirmCardPin.value;
    final isUSDCard = state.isUSDCard;
    final isMasterCard = state.isMasterCard;
    final isPlatinum = state.platinum;

    final isFormValid =
        FormzValid([amount, cardPin, confirmCardPin]).isFormValid && didMatched;

    final newState = state.copyWith(
      amount: amount,
      cardPin: cardPin,
      confirmCardPin: confirmCardPin,
      isMasterCard: isMasterCard,
      platinum: isPlatinum,
      isUSDCard: isUSDCard,
      status: isFormValid ? CreateVirtualCardStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;
    final res = await _createCardUseCases(
      CreateCardParams(
        pin: cardPin.value,
        cardLimit: isPlatinum ? '1000000' : '500000',
        amount: amount.value,
        cardBrand: isMasterCard ? 'Mastercard' : 'Visa',
      ),
    );

    res.fold(
      (l) => emit(
        state.copyWith(
          status: CreateVirtualCardStatus.failure,
          message: l.message,
        ),
      ),
      (r) {
        emit(state.copyWith(
          status: CreateVirtualCardStatus.success,
        ));

        onSubmit?.call();
      },
    );
  }

  void _errorFormatter(Object error, StackTrace stackTrace) {
    addError(error, stackTrace);
    // final status = switch (error) {
    //   AuthException(:final statusCode) => switch (statusCode?.parse) {
    //       HttpStatus.tooManyRequests => ForgotPasswordStatus.tooManyRequests,
    //       _ => ForgotPasswordStatus.failure,
    //     },
    //   _ => ForgotPasswordStatus.failure,
    // };

    emit(state.copyWith(status: CreateVirtualCardStatus.failure));
  }
}
