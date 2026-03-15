import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'giveaway_winners_state.dart';

class GiveawayWinnersCubit extends Cubit<GiveawayWinnersState> {
  final GetGiveawayWinnersUseCase _getGiveawayWinnersUseCase;
  GiveawayWinnersCubit({
    required GetGiveawayWinnersUseCase getGiveawayWinnersUseCase,
  }) : _getGiveawayWinnersUseCase = getGiveawayWinnersUseCase,
       super(GiveawayWinnersState.initial());

  void onFilterChanged(String label) {
    emit(state.copyWith(filter: label));
  }

  Future<void> getGiveawayWinners() async {
    emit(state.copyWith(status: GiveawayWinnersStatus.loading));
    final result = await _getGiveawayWinnersUseCase(NoParam());

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: GiveawayWinnersStatus.failure,
            message: failure.message,
          ),
        );
      },
      (winners) {
        emit(
          state.copyWith(
            status: GiveawayWinnersStatus.success,
            winners: winners,
          ),
        );
      },
    );
  }
}
