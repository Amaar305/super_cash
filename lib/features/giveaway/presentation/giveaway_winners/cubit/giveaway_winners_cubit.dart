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
          state.copyWith(status: GiveawayWinnersStatus.success, winners: list),
        );
      },
    );
  }
}

final list = [
  GiveawayWinner(
    id: '1',
    winner: 'John Doe',
    amount: '1000',
    createdAt: DateTime.now(),
    type: GiveawayType(
      id: 1,
      name: 'Airtime PIN',
      code: 'airtime-pin',
      description: '',
    ),
  ),

  GiveawayWinner(
    id: '2',
    winner: 'Janet Jackson',
    amount: '2000',
    createdAt: DateTime.now(),
    type: GiveawayType(id: 2, name: 'Data', code: 'data-code', description: ''),
  ),
  GiveawayWinner(
    id: '3',
    winner: 'Auwal Jackson',
    amount: '100',
    createdAt: DateTime(2026, 2, 25),
    type: GiveawayType(id: 2, name: 'Data', code: 'data-code', description: ''),
  ),
  GiveawayWinner(
    id: '3',
    winner: 'Super Cash',
    amount: '100',
    createdAt: DateTime(2026, 3, 2),
    type: GiveawayType(
      id: 2,
      name: 'Airtime PIN',
      code: 'airtime-pin',
      description: '',
    ),
  ),
];
