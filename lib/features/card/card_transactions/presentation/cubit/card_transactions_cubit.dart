import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

import '../../card_transactions.dart';

part 'card_transactions_state.dart';

part 'card_transactions_cubit.g.dart';

class CardTransactionsCubit extends HydratedCubit<CardTransactionsState> {
  final String _cardId;
  final FetchCardTransactionsUseCase _fetchCardTransactionsUseCase;
  bool _isFetching = false;

  CardTransactionsCubit({
    required String cardId,
    required FetchCardTransactionsUseCase fetchCardTransactionsUseCase,
  })  : _cardId = cardId,
        _fetchCardTransactionsUseCase = fetchCardTransactionsUseCase,
        super(CardTransactionsState.initial());

  Future<void> fetchInitialTransactions() async {

    // if (state.status.isLoading || state.transactions.isNotEmpty) return;

    emit(state.copyWith(
      status: CardTransactionsStatus.loading,
      transactions: [],
      data: [],
      hasReachedMax: false,
    ));

    try {
      final result = await _fetchCardTransactionsUseCase(
        FetchCardTransactionsParams(cardId: _cardId),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            status: CardTransactionsStatus.failure,
            message: failure.message,
          ));
        },
        (response) {
          emit(state.copyWith(
            status: CardTransactionsStatus.success,
            transactions: response.transactions,
            data: response.transactions,
            paginationMeta: response.meta,
            nextPageUrl: response.meta.next,
            hasReachedMax: response.meta.next == null,
            message: 'Initial transactions loaded successfully',
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: CardTransactionsStatus.failure,
        message: 'Failed to load initial transactions',
      ));
    }
  }

  Future<void> fetchNextPage() async {
    if (_isFetching || state.hasReachedMax || state.nextPageUrl == null) return;

    _isFetching = true;
    emit(state.copyWith(status: CardTransactionsStatus.loading));

    try {
      final page = state.paginationMeta?.pages ?? 1 + 1;
      final result = await _fetchCardTransactionsUseCase(
        FetchCardTransactionsParams(
          page: page,
          cardId: _cardId,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            status: CardTransactionsStatus.failure,
            message: failure.message,
          ));
        },
        (response) {
          final newTransactions = [
            ...state.transactions,
            ...response.transactions
          ];
          emit(state.copyWith(
            status: CardTransactionsStatus.success,
            transactions: newTransactions,
            data: newTransactions,
            paginationMeta: response.meta,
            nextPageUrl: response.meta.next,
            hasReachedMax: response.meta.next == null,
            message: 'More transactions loaded successfully',
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: CardTransactionsStatus.failure,
        message: 'Failed to load more transactions',
      ));
    } finally {
      _isFetching = false;
    }
  }

  void refreshTransactions() {
    emit(CardTransactionsState.initial());
    fetchInitialTransactions();
  }

  void sortByAmount() {
    final isSortAsc = state.isSortAsc;
    final transactions = List<CardTransaction>.from(state.data);

    if (isSortAsc) {
      transactions.sort(
        (a, b) => a.amount.compareTo(b.amount),
      );
    } else {
      transactions.sort(
        (a, b) => b.amount.compareTo(a.amount),
      );
    }
    emit(state.copyWith(data: transactions, isSortAsc: !isSortAsc));
  }

  void searchTransaction(String value) {
    if (isClosed || value.isEmpty) return;

    try {
      final data = List<CardTransaction>.from(state.transactions);

      final result = data.where(
        (element) {
          value = value.toLowerCase();
          final conditions =
              element.cardTransactionType.toLowerCase().contains(value) ||
                  element.description.toLowerCase().contains(value);
          return conditions;
        },
      ).toList();

      emit(state.copyWith(data: result));
    } catch (e) {
      emit(state.copyWith(
        status: CardTransactionsStatus.failure,
        message: 'Failed to search transactions',
      ));
    }
  }

  @override
  String get id => _cardId;

  @override
  CardTransactionsState? fromJson(Map<String, dynamic> json) {
    return CardTransactionsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CardTransactionsState state) => state.toJson();
}
