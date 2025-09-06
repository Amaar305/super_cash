import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/virtual_card/virtual_card.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/shared.dart';

part 'virtual_card_state.dart';

class VirtualCardCubit extends Cubit<VirtualCardState> {
  final FetchVirtualCardUseCase _fetchVirtualCardUseCase;
  VirtualCardCubit({required FetchVirtualCardUseCase fetchVirtualCardUseCase})
    : _fetchVirtualCardUseCase = fetchVirtualCardUseCase,
      super(
        VirtualCardState(
          cards: const [],
          message: '',
          status: VirtualCardStatus.initial,
        ),
      );

  void fetchCards() async {
    emit(state.copyWith(status: VirtualCardStatus.loading));

    final res = await _fetchVirtualCardUseCase(NoParam());

    res.fold(
      (l) => emit(
        state.copyWith(status: VirtualCardStatus.failure, message: l.message),
      ),
      (r) => emit(state.copyWith(cards: r, status: VirtualCardStatus.success)),
    );
  }
}
