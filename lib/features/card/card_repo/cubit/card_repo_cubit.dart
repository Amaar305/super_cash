import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card_repo/card_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared/shared.dart';

part 'card_repo_state.dart';

class CardRepoCubit extends Cubit<CardRepoState> {
  final GetCardFeeSettingsUseCase _getCardFeeSettingsUseCase;
  CardRepoCubit({required GetCardFeeSettingsUseCase getCardFeeSettingsUseCase})
    : _getCardFeeSettingsUseCase = getCardFeeSettingsUseCase,
      super(CardRepoState.initail());

  Future<void> fetchCardFeeSettings() async {
    if (isClosed) return;
    try {
      emit(state.copyWith(status: CardRepoStatus.loading));
      final res = await _getCardFeeSettingsUseCase(NoParam());

      res.fold(
        (failure) {
          logE('Fail to fetch card fee settings ${failure.message}');
          emit(
            state.copyWith(
              status: CardRepoStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: CardRepoStatus.success,
              message: 'Successfully fetched card fee settings',
              cardFeeSettings: success,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      logE('Fail to fetch card fee settings $error', stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: CardRepoStatus.failure,
          message: 'Fail to fetch card fee settings',
        ),
      );
    }
  }
}
