import 'package:super_cash/features/auth/forgot_password/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final RequestOtpWithEmailUseCase _requestOtpWithEmailUseCase;
  ForgotPasswordCubit({
    required RequestOtpWithEmailUseCase requestOtpWithEmailUseCase,
  }) : _requestOtpWithEmailUseCase = requestOtpWithEmailUseCase,
       super(ForgotPasswordState.initial());

  /// Emits initial state of login screen.
  void resetState() => emit(const ForgotPasswordState.initial());

  ///Change forgot password type [withEmail]
  void changeType(bool withEmail) {
    if (withEmail == state.withEmail) return;

    emit(state.copyWith(withEmail: withEmail));
  }

  /// Email value was changed, triggering new changes in state.
  void onEmailChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final shouldValidate = previousEmailState.invalid;
    final newEmailState = shouldValidate
        ? Email.dirty(newValue)
        : Email.pure(newValue);

    final newScreenState = previousScreenState.copyWith(email: newEmailState);

    emit(newScreenState);
  }

  /// Email field was unfocused, here is checking if previous state with email
  /// was valid, in order to indicate it in state after unfocus.
  void onEmailUnfocused() {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Email.dirty(previousEmailValue);
    final newScreenState = previousScreenState.copyWith(email: newEmailState);
    emit(newScreenState);
  }

  /// Email value was changed, triggering new changes in state.
  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.phone;
    final shouldValidate = previousEmailState.invalid;
    final newEmailState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = previousScreenState.copyWith(phone: newEmailState);

    emit(newScreenState);
  }

  /// Email field was unfocused, here is checking if previous state with email
  /// was valid, in order to indicate it in state after unfocus.
  void onPhoneUnfocused() {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.phone;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Phone.dirty(previousEmailValue);
    final newScreenState = previousScreenState.copyWith(phone: newEmailState);
    emit(newScreenState);
  }

  Future<void> onSubmit({VoidCallback? onSuccess}) async {
    final email = Email.dirty(state.email.value);
    final phone = Phone.dirty(state.phone.value);
    final withEmail = state.withEmail;

    final isFormValid = FormzValid([
      if (withEmail) email else phone,
    ]).isFormValid;

    final newState = state.copyWith(
      email: withEmail ? email : null,
      phone: !withEmail ? phone : null,
      status: isFormValid ? ForgotPasswordStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    final res = await _requestOtpWithEmailUseCase(
      RequestOtpWithEmailParam(email: email.value),
    );

    if (isClosed) return;
    res.fold(
      (l) => emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          message: l.message,
        ),
      ),
      (r) {
        emit(state.copyWith(status: ForgotPasswordStatus.success, response: r));

        onSuccess?.call();
      },
    );
    // message:l.message

    // try {
    //   await Future.delayed(Duration(seconds: 10));
    //   emit(state.copyWith(status: ForgotPasswordStatus.success));
    //   final newState = state.copyWith(status: ForgotPasswordStatus.success);
    //   if (isClosed) return;
    //   emit(newState);
    //   onSuccess?.call();
    // } catch (error, stackTrace) {
    //   _errorFormatter(error, stackTrace);
    // }
  }
}
