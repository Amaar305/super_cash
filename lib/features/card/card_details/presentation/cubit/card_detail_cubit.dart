import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

import '../../domain/use_cases/card_details_use_cases.dart';

part 'card_detail_state.dart';

part 'card_detail_cubit.g.dart';

class CardDetailCubit extends HydratedCubit<CardDetailState> {
  final String _cardId;
  final CardDetailsUseCase _cardDetailsUseCase;
  final FreezeCardUseCase _freezeCardUseCase;

  CardDetailCubit({
    required String cardId,
    required CardDetailsUseCase cardDetailsUseCase,
    required FreezeCardUseCase freezeCardUseCase,
  })  : _cardId = cardId,
        _cardDetailsUseCase = cardDetailsUseCase,
        _freezeCardUseCase = freezeCardUseCase,
        super(CardDetailState.initial());
  @override
  String get id => _cardId;

  void resetState() => emit(CardDetailState.initial());

  void fetchCardDetails({bool forceRefresh = false}) async {
    if (state.cardDetails != null && !forceRefresh) {
      // Data already available and we're not forcing refresh
      return;
    }

    emit(state.copyWith(status: CardDetailStatus.loading));

    final res = await _cardDetailsUseCase(
      CardDetailsParams(cardId: _cardId),
    );

    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(status: CardDetailStatus.failure, message: l.message),
      ),
      (r) => emit(
        state.copyWith(
          cardDetails: r,
          status: CardDetailStatus.success,
        ),
      ),
    );
  }

  void onCardDetailsExpanded() {
    final previousScreenState = state;

    final previousCardDetailIsExpandedState =
        previousScreenState.isCardDetailsExpanded;

    final newScreenState = previousScreenState.copyWith(
      isCardDetailsExpanded: !previousCardDetailIsExpandedState,
      isCardBillingAddressExpanded: false,
    );

    emit(newScreenState);
  }

  void onCardBillingAddressExpanded() {
    final previousScreenState = state;

    final previousCardBillingAddressExpandedState =
        previousScreenState.isCardBillingAddressExpanded;

    final newScreenState = previousScreenState.copyWith(
      isCardBillingAddressExpanded: !previousCardBillingAddressExpandedState,
      isCardDetailsExpanded: false,
    );

    emit(newScreenState);
  }

  Future<bool> onAppleProductSwitched(
    bool? newValue, {
    VoidCallback? onFinished,
  }) async {
    try {
      emit(state.copyWith(status: CardDetailStatus.loading));

      final newState = state.copyWith(
        appleProduct: newValue,
        status: CardDetailStatus.success,
      );

      emit(newState);
      onFinished?.call();
      return true;
    } catch (e, s) {
      addError(e, s);
      return true;
    }
  }

  Future<void> onFreezeCard({
    void Function(String)? onFreezed,
  }) async {
    // Early return if already closed
    if (isClosed) return;

    emit(state.copyWith(status: CardDetailStatus.loading));

    try {
      final result = await _freezeCardUseCase(
        FreezeCardParam(cardId: _cardId),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
              status: CardDetailStatus.failure, message: failure.message));
        },
        (response) {
          _handleFreezeResponse(response, onFreezed);
        },
      );

      fetchCardDetails(forceRefresh: true);
    } catch (error) {
      emit(state.copyWith(
        status: CardDetailStatus.failure,
        message: 'An unexpected error occurred',
      ));
      // Consider adding error logging here
      // logError(error, stackTrace);
    }
  }

  void _handleFreezeResponse(
    Map<String, dynamic> response,
    void Function(String)? callback,
  ) {
    final isValidResponse = response['status'] == 'success';
    final cardStatus = isValidResponse ? response['card_status'] : false;
    final message = isValidResponse
        ? response['message']?.toString() ?? 'Card status updated'
        : 'Invalid response from server';

    final updatedCardDetails = state.cardDetails?.copyWith(
      isActive: cardStatus,
    );

    emit(state.copyWith(
      status: CardDetailStatus.success,
      cardDetails: updatedCardDetails,
      message: message,
    ));

    callback?.call(message);
  }

  @override
  CardDetailState fromJson(Map<String, dynamic> json) =>
      CardDetailState.fromJson(json);

  @override
  Map<String, dynamic> toJson(CardDetailState state) => state.toJson();
}
