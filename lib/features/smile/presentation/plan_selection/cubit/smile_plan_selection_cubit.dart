import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

part 'smile_plan_selection_state.dart';

/// Owns exactly one thing: loading the list of Smile Data plans the user can
/// pick from. Nothing about email verification or purchasing lives here.
class SmilePlanSelectionCubit extends Cubit<SmilePlanSelectionState> {
  final FetchSmilePlansUseCase _fetchSmilePlansUseCase;

  SmilePlanSelectionCubit({
    required FetchSmilePlansUseCase fetchSmilePlansUseCase,
  }) : _fetchSmilePlansUseCase = fetchSmilePlansUseCase,
       super(const SmilePlanSelectionState.initial());

  Future<void> fetchPlans() async {
    emit(state.copyWith(status: SmilePlanSelectionStatus.loading));

    final res = await _fetchSmilePlansUseCase(NoParam());
    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(
          status: SmilePlanSelectionStatus.failure,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(status: SmilePlanSelectionStatus.loaded, plans: r.plans),
      ),
    );
  }

  void onSearchChanged(String query) =>
      emit(state.copyWith(searchQuery: query));
}
