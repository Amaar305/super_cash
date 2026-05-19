import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'giveaway_detail_state.dart';

class GiveawayDetailCubit extends Cubit<GiveawayDetailState> {
  GiveawayDetailCubit({
    required CheckGiveawayEligibilityUseCase checkGiveawayEligibilityUseCase,
  }) : _checkGiveawayEligibilityUseCase = checkGiveawayEligibilityUseCase,
       super(const GiveawayDetailState.initial());

  final CheckGiveawayEligibilityUseCase _checkGiveawayEligibilityUseCase;

  void navigateToProductGiveaway() {
    emit(
      state.copyWith(
        shouldNavigateOnSuccess: true,
        status: GiveawayDetailStatus.eligible,
      ),
    );
  }

  Future<void> checkEligibility({
    required String giveawayTypeId,
    bool shouldNavigateOnSuccess = false,
  }) async {
    if (state.status.isLoading) return;

    emit(
      state.copyWith(
        status: GiveawayDetailStatus.loading,
        shouldNavigateOnSuccess: shouldNavigateOnSuccess,
      ),
    );

    final result = await _checkGiveawayEligibilityUseCase(
      CheckGiveawayEligibilityParams(giveawayTypeId: giveawayTypeId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: GiveawayDetailStatus.failure,
          message: failure.message,
          shouldNavigateOnSuccess: shouldNavigateOnSuccess,
        ),
      ),
      (eligibility) => emit(
        state.copyWith(
          status: eligibility.isEligible
              ? GiveawayDetailStatus.eligible
              : GiveawayDetailStatus.notEligible,
          result: eligibility,
          message: eligibility.message,
          shouldNavigateOnSuccess: shouldNavigateOnSuccess,
        ),
      ),
    );
  }
}
