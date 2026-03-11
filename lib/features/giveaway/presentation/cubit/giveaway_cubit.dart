import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/domain/domain.dart';

part 'giveaway_state.dart';

class GiveawayCubit extends Cubit<GiveawayState> {
  final GetGiveawayTypesUseCase _getGiveawayTypesUseCase;
  final GetGiveawaysUseCase _getGiveawaysUseCase;

  GiveawayCubit({
    required GetGiveawayTypesUseCase getGiveawayTypesUseCase,
    required GetGiveawaysUseCase getGiveawaysUseCase,
  }) : _getGiveawaysUseCase = getGiveawaysUseCase,
       _getGiveawayTypesUseCase = getGiveawayTypesUseCase,
       super(GiveawayState.initial());

  void filterbyStatus(UpcomingGiveawayStatus status) {
    emit(state.copyWith(selectedStatus: status));
  }

  Future<void> getGiveaways() async {
    emit(state.copyWith(status: GiveawayStatus.loading));

    final result = await _getGiveawaysUseCase(NoParam());
    if (isClosed) return;

    result.fold(
      (l) => emit(
        state.copyWith(errorMessage: l.message, status: GiveawayStatus.failure),
      ),
      (r) => emit(state.copyWith(status: GiveawayStatus.success, giveaways: r)),
    );
  }

  Future<void> getGiveawayTypes() async {
    emit(state.copyWith(status: GiveawayStatus.loading));

    final result = await _getGiveawayTypesUseCase(NoParam());

    if (isClosed) return;

    result.fold(
      (l) => emit(
        state.copyWith(errorMessage: l.message, status: GiveawayStatus.failure),
      ),
      (r) => emit(state.copyWith(status: GiveawayStatus.success, types: r)),
    );
  }
}
