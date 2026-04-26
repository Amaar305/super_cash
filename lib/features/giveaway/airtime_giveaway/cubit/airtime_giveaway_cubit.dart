import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'airtime_giveaway_state.dart';

class AirtimeGiveawayCubit extends Cubit<AirtimeGiveawayState> {
  final GetAirtimeGiveawayPinsUseCase _getAirtimeGiveawayPinsUseCase;
  final ClaimAirtimeGiveawayUseCase _claimAirtimeGiveawayUseCase;

  final String _giveawayTypeId;

  AirtimeGiveawayCubit({
    required GetAirtimeGiveawayPinsUseCase getAirtimeGiveawayPinsUseCase,
    required ClaimAirtimeGiveawayUseCase claimAirtimeGiveawayUseCase,
    required String giveawayTypeId,
  }) : _getAirtimeGiveawayPinsUseCase = getAirtimeGiveawayPinsUseCase,
       _claimAirtimeGiveawayUseCase = claimAirtimeGiveawayUseCase,
       _giveawayTypeId = giveawayTypeId,
       super(AirtimeGiveawayState.initial());

  // void toggleStatus() async {
  //   emit(state.copyWith(status: AirtimeGiveawayStatus.processing));

  //   await Future.delayed(Duration(seconds: 2));

  //   emit(state.copyWith(status: AirtimeGiveawayStatus.processed));
  // }

  Future<void> getAirtimeGiveawayPins() async {
    emit(state.copyWith(status: AirtimeGiveawayStatus.loading));

    final result = await _getAirtimeGiveawayPinsUseCase(NoParam());

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AirtimeGiveawayStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (pins) => emit(
        state.copyWith(
          status: AirtimeGiveawayStatus.loaded,
          giveawayPins: pins,
        ),
      ),
    );
  }

  Future<void> claimAirtimeGiveaway({
    required String planId,
    void Function(AirtimeGiveawayPin giveawayPin)? onSuccess,
  }) async {
    emit(state.copyWith(status: AirtimeGiveawayStatus.processing));

    final result = await _claimAirtimeGiveawayUseCase(
      ClaimAirtimeGiveawayParams(giveawayId: _giveawayTypeId, planId: planId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AirtimeGiveawayStatus.processingError,
          errorMessage: failure.message,
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            status: AirtimeGiveawayStatus.processed,
            claimedPin: data,
            giveawayPins: List.from(state.giveawayPins)
              ..removeWhere((pin) => pin.id == data.id)
              ..add(data),
          ),
        );
        onSuccess?.call(data);
      },
    );
  }
}
