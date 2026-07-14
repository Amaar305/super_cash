import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/kyc.dart';

part 'kyc_bvn_state.dart';

class KycBvnCubit extends Cubit<KycBvnState> {
  final GetBvnUseCase _getBvnUseCase;
  final SubmitBvnUseCase _submitBvnUseCase;

  KycBvnCubit({
    required GetBvnUseCase getBvnUseCase,
    required SubmitBvnUseCase submitBvnUseCase,
  })  : _getBvnUseCase = getBvnUseCase,
        _submitBvnUseCase = submitBvnUseCase,
        super(const KycBvnState.initial());

  Future<void> getBvn() async {
    emit(state.copyWith(status: KycBvnStatus.loading));
    final result = await _getBvnUseCase(NoParam());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: KycBvnStatus.failure,
        message: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: KycBvnStatus.success,
        bvnResponse: response,
        bvn: response.bvn ?? '',
      )),
    );
  }

  void onBvnChanged(String value) {
    emit(state.copyWith(bvn: value, clearBvnError: true));
  }

  Future<void> submitBvn() async {
    final bvn = state.bvn.trim();

    if (bvn.isEmpty) {
      emit(state.copyWith(bvnError: 'BVN is required.'));
      return;
    }
    if (bvn.length != 11 || int.tryParse(bvn) == null) {
      emit(state.copyWith(bvnError: 'BVN must be exactly 11 digits.'));
      return;
    }

    emit(state.copyWith(status: KycBvnStatus.submitting, clearBvnError: true));
    final result = await _submitBvnUseCase(bvn);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: KycBvnStatus.failure,
        message: failure.message,
      )),
      (success) => emit(state.copyWith(
        status: KycBvnStatus.submitted,
        message: success.message,
      )),
    );
  }
}
