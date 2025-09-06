import 'package:super_cash/features/history/history.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

part 'history_state.dart';
part 'history_cubit.g.dart';

class HistoryCubit extends HydratedCubit<HistoryState> {
  final FetchTransactionsUseCase _fetchTransactionsUseCase;
  HistoryCubit({required FetchTransactionsUseCase fetchTransactionsUseCase})
    : _fetchTransactionsUseCase = fetchTransactionsUseCase,
      super(HistoryState.initial());

  bool _isFetching = false;
  int _currentPage = 1;

  Future<void> fetchInitialTransactions({
    bool forceReload = false,
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? transactionType,
  }) async {
    if (isClosed) return;

    if (state.transactions.isNotEmpty && !forceReload) return;

    emit(
      state.copyWith(
        status: HistoryStatus.loading,
        transactions: [],
        data: [],
        hasReachedMax: false,
        currentPage: 1,
      ),
    );
    try {
      final res = await _fetchTransactionsUseCase(
        FetchTransactionsParams(
          page: _currentPage,
          start: start,
          end: end,
          status: status,
          transactionType: transactionType,
        ),
      );

      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: HistoryStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: HistoryStatus.success,
              message: 'Initial transactions loaded successfully',
              transactions: success.transactions,
              data: success.transactions,
              hasReachedMax: success.paginationMeta.next == null,
              nextPageUrl: success.paginationMeta.next,
              paginationMeta: success.paginationMeta,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HistoryStatus.failure,
          message: 'Failed to load initial transactions',
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || state.hasReachedMax || state.nextPageUrl == null) return;

    _isFetching = true;
    _currentPage++;

    emit(state.copyWith(status: HistoryStatus.loading));

    try {
      final res = await _fetchTransactionsUseCase(
        FetchTransactionsParams(
          page: _currentPage,
          start: state.start,
          end: state.end,
          status: state.transactionStatus,
        ),
      );

      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: HistoryStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          final newTransactions = [
            ...state.transactions,
            ...success.transactions,
          ];
          // print(newTransactions.length);
          emit(
            state.copyWith(
              status: HistoryStatus.success,
              message: 'More transactions loaded successfully',
              transactions: newTransactions,
              data: newTransactions,
              hasReachedMax: success.paginationMeta.next == null,
              nextPageUrl: success.paginationMeta.next,
              paginationMeta: success.paginationMeta,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HistoryStatus.failure,
          message: 'Failed to load next transactions page',
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  void refreshTransactions() {
    emit(HistoryState.initial());
    _currentPage = 1;
    _isFetching = false;
    fetchInitialTransactions(forceReload: true);
  }

  void searchTransaction(String value) {
    if (isClosed) return;

    try {
      final data = List<TransactionResponse>.from(state.transactions);

      if (value.isEmpty) {
        emit(state.copyWith(data: data));
        return;
      }

      final result = data.where((element) {
        value = value.toLowerCase();
        final conditions = element.description.toLowerCase().contains(value);
        return conditions;
      }).toList();

      emit(state.copyWith(data: result));
    } catch (e) {
      emit(
        state.copyWith(
          status: HistoryStatus.failure,
          message: 'Failed to search transactions',
        ),
      );
    }
  }

  void filterTransactions({
    DateTime? start,
    DateTime? end,
    TransactionStatus? status,
    TransactionType? type,
  }) {
    emit(
      state.copyWith(
        start: start,
        end: end,
        transactionStatus: status,
        transactionType: type,
      ),
    );
    fetchInitialTransactions(
      forceReload: true,
      start: start ?? state.start,
      end: end ?? state.end,
      status: status ?? state.transactionStatus,
      transactionType: type ?? state.transactionType,
      // type: type,
    );
  }

  @override
  HistoryState? fromJson(Map<String, dynamic> json) {
    return HistoryState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HistoryState state) => state.toJson();
}
