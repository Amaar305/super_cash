import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/kyc.dart';

part 'kyc_status_state.dart';

class KycStatusCubit extends Cubit<KycStatusState> {
  final GetKycStatusUseCase _getKycStatusUseCase;
  final RegisterCardholderUseCase _registerCardholderUseCase;

  KycStatusCubit({
    required GetKycStatusUseCase getKycStatusUseCase,
    required RegisterCardholderUseCase registerCardholderUseCase,
  })  : _getKycStatusUseCase = getKycStatusUseCase,
        _registerCardholderUseCase = registerCardholderUseCase,
        super(KycStatusState.intial());

  Future<void> getKycStatus() async {
    emit(state.copyWith(status: KycStatusStatus.loading));
    try {
      final res = await _getKycStatusUseCase(NoParam());

      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(status: KycStatusStatus.failure, message: l.message),
        ),
        (r) =>
            emit(state.copyWith(kycStatus: r, status: KycStatusStatus.success)),
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch kyc status $error', stackTrace: stackTrace);
    }
  }

  Future<void> registerCardholder() async {
    emit(state.copyWith(status: KycStatusStatus.registering));
    final result = await _registerCardholderUseCase(NoParam());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: KycStatusStatus.failure,
        message: failure.message,
      )),
      (cardholder) => emit(state.copyWith(
        status: KycStatusStatus.registered,
        cardholder: cardholder,
        message: cardholder.isActive
            ? 'Card account activated successfully.'
            : 'Cardholder registered. Your account is being reviewed.',
      )),
    );
  }

  Future<void> silentRefresh() async {
    try {
      final res = await _getKycStatusUseCase(NoParam());
      if (isClosed) return;
      res.fold(
        (_) => null,
        (r) => emit(state.copyWith(kycStatus: r, status: KycStatusStatus.success)),
      );
    } catch (_) {}
  }
}
