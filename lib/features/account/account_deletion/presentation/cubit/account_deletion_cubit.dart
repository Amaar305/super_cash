import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/account/account_deletion/domain/domain.dart';

part 'account_deletion_state.dart';

class AccountDeletionCubit extends Cubit<AccountDeletionState> {
  AccountDeletionCubit({
    required AccountDeletionRequestedUseCase accountDeletionRequestedUseCase,
  })  : _accountDeletionRequestedUseCase = accountDeletionRequestedUseCase,
        super(const AccountDeletionState.initial());

  final AccountDeletionRequestedUseCase _accountDeletionRequestedUseCase;

  void onReasonChanged(String value) {
    emit(
      state.copyWith(
        reason: value,
        reasonError: value.trim().isNotEmpty ? null : state.reasonError,
        message: '',
      ),
    );
  }

  bool validateReason() {
    final trimmed = state.reason.trim();
    final error =
        trimmed.isEmpty ? 'Please share a reason so we can improve.' : null;

    emit(
      state.copyWith(
        reasonError: error,
      ),
    );

    return error == null;
  }

  Future<void> submit({void Function()? onSuccess}) async {
    final isValid = validateReason();
    if (!isValid || state.status.isLoading) return;

    emit(
      state.copyWith(
        status: AccountDeletionStatus.loading,
        message: '',
      ),
    );

    final res = await _accountDeletionRequestedUseCase(
      AccountDeletionRequestedUseCaseParams(
        reason: state.reason.trim(),
      ),
    );

    if (isClosed) return;

    res.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AccountDeletionStatus.failure,
            message: failure.message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: AccountDeletionStatus.success,
            message:
                'Your account is now deactivated. We will permanently delete your data after 90 days.',
          ),
        );
        onSuccess?.call();
      },
    );
  }
}
