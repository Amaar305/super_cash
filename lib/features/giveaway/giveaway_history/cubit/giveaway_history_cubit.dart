import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'giveaway_history_state.dart';

class GiveawayHistoryCubit extends Cubit<GiveawayHistoryState> {
  final GetGiveawayHistoriesUseCase _getGiveawayHistoriesUseCase;

  GiveawayHistoryCubit({
    required GetGiveawayHistoriesUseCase getGiveawayHistoriesUseCase,
  }) : _getGiveawayHistoriesUseCase = getGiveawayHistoriesUseCase,
       super(GiveawayHistoryState.initial());

  void applyFilters(
    String? quickNetwork,
    String? selectedType,
    String? highAmount,
  ) {
    emit(
      state.copyWith(
        quickNetwork: quickNetwork,
        selectedType: selectedType,
        highAmount: highAmount,
      ),
    );
  }

  Future<void> getHistories() async {
    emit(state.copyWith(status: GiveawayHistoryStatus.loading));

    final res = await _getGiveawayHistoriesUseCase(NoParam());

    if (isClosed) return;

    res.fold(
      (l) {
        emit(
          state.copyWith(
            message: l.message,
            status: GiveawayHistoryStatus.failure,
          ),
        );
      },
      (r) {
        emit(state.copyWith(data: r, status: GiveawayHistoryStatus.success));
      },
    );
  }

  Future<void> refreshTransactions() async {
    emit(
      GiveawayHistoryState._(
        message: '',
        status: GiveawayHistoryStatus.loading,
        highAmount: null,
        quickNetwork: null,
        selectedType: null,
        data: [],
      ),
    );
    await getHistories();
  }
}
