import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../domain/usecases/change_password_use_case.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordCubit({
    required ChangePasswordUseCase changePasswordUseCase,
  })  : _changePasswordUseCase = changePasswordUseCase,
        super(ChangePasswordState.initial());

  void changeCurrentPasswordObsecure() =>
      emit(state.copyWith(showCurrentPassword: !state.showCurrentPassword));
  void changeNewPasswordObsecure() =>
      emit(state.copyWith(shownewPassword: !state.shownewPassword));
  void changeConfirmPasswordObsecure() =>
      emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));

  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emmiting new
  /// [Password] validation state.
  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.currentPassword;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
            newValue,
          )
        : Password.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      currentPassword: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.currentPassword;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      currentPassword: newPasswordState,
    );
    emit(newScreenState);
  }

  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emmiting new
  /// [Password] validation state.
  void onNewPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.newPassword;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
            newValue,
          )
        : Password.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      newPassword: newPasswordState,
    );

    emit(newScreenState);
  }

  void onNewPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.newPassword;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      newPassword: newPasswordState,
    );
    emit(newScreenState);
  }

  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emmiting new
  /// [Password] validation state.
  void onConfirmPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousConfirmPasswordState = previousScreenState.confirmPassword;
    final shouldValidate = previousConfirmPasswordState.invalid;
    final didMatched = newValue == previousScreenState.newPassword.value;

    final newPasswordState = shouldValidate
        ? Password.dirty(
            newValue,
          )
        : Password.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      confirmPassword: newPasswordState,
      doesNotMatchedMessage: !didMatched ? 'Password does not match' : '',
    );

    emit(newScreenState);
  }

  void onConfirmPasswordUnfocused() {
    final previousScreenState = state;
    final previousConfirmPasswordState = previousScreenState.confirmPassword;
    final previousPasswordValue = previousConfirmPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      confirmPassword: newPasswordState,
    );
    emit(newScreenState);
  }

  void submit([void Function(String)? onSuccess]) async {
    try {
      final password = Password.dirty(state.currentPassword.value);
      final password2 = Password.dirty(state.newPassword.value);
      final password3 = Password.dirty(state.confirmPassword.value);
      final didMatched = password2.value == password3.value;

      final isFormValid =
          FormzValid([password, password2, password3]).isFormValid &&
              didMatched;

      final newState = state.copyWith(
        currentPassword: password,
        newPassword: password2,
        confirmPassword: password2,
        status: isFormValid ? ChangePasswordStatus.loading : null,
        doesNotMatchedMessage: !didMatched ? 'Password does not match!' : '',
      );
      emit(newState);

      if (!isFormValid) return;

      final res = await _changePasswordUseCase(
        ChangePasswordParams(
          currentPassword: password.value,
          newPassword: password2.value,
          confirmPassword: password2.value,
        ),
      );

      if (isClosed) return;

      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ChangePasswordStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(state.copyWith(
            status: ChangePasswordStatus.success,
          ));
          onSuccess?.call(success);
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to change user password $error', stackTrace: stackTrace);
      emit(
        state.copyWith(
          message: 'Failed to change password',
          status: ChangePasswordStatus.failure,
        ),
      );
    }
  }
}
