import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/manage_beneficiary.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

part 'save_update_beneficiary_state.dart';

class SaveUpdateBeneficiaryCubit extends Cubit<SaveUpdateBeneficiaryState> {
  SaveUpdateBeneficiaryCubit({
    required SaveBeneficiaryUseCase saveBeneficiaryUseCase,
    required UpdateBeneficiaryUseCase updateBeneficiaryUseCase,
    Beneficiary? beneficiary,
  }) : _saveBeneficiaryUseCase = saveBeneficiaryUseCase,
       _updateBeneficiaryUseCase = updateBeneficiaryUseCase,
       super(SaveUpdateBeneficiaryState.initial(beneficiary: beneficiary));

  final SaveBeneficiaryUseCase _saveBeneficiaryUseCase;
  final UpdateBeneficiaryUseCase _updateBeneficiaryUseCase;

  /// [FullName] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [FullName] and emmiting new [FullName]
  /// validation state.
  void onFirstNameChanged(String newValue) {
    final previousScreenState = state;
    final previousFirstNameState = previousScreenState.name;
    final shouldValidate = previousFirstNameState.invalid;
    final newFullNameState = shouldValidate
        ? FullName.dirty(newValue)
        : FullName.pure(newValue);

    final newScreenState = state.copyWith(name: newFullNameState);

    emit(newScreenState);
  }

  /// [FullName] field was unfocused, here is checking if previous state with
  /// [FullName] was valid, in order to indicate it in state after unfocus.
  void onFirstNameUnfocused() {
    final previousScreenState = state;
    final previousFullNameState = previousScreenState.name;
    final previousFullNameValue = previousFullNameState.value;

    final newFullNameState = FullName.dirty(previousFullNameValue);
    final newScreenState = previousScreenState.copyWith(name: newFullNameState);
    emit(newScreenState);
  }

  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = state.copyWith(phone: newSurnameState);

    emit(newScreenState);
  }

  void onPhoneUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Phone.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      phone: newUsernameState,
    );
    emit(newScreenState);
  }

  void onNetworkChanged(String network) async {
    if (state.network == network || isClosed) return;

    final newState = state;
    emit(newState.copyWith(network: network));
  }

  Future<void> saveBeneficiary([void Function(Beneficiary)? onSaved]) async {
    if (state.status.isLoading || isClosed) return;

    final network = state.network;
    final phone = Phone.dirty(state.phone.value);
    final name = FullName.dirty(state.name.value);

    final isFormValid =
        FormzValid([phone, name]).isFormValid && network != null;

    final newState = state.copyWith(
      status: !isFormValid ? null : SaveUpdateBeneficiaryStatus.loading,
      phone: phone,
      name: name,
      network: network,
      networkErrorMsg: network == null ? 'Please select a network' : null,
    );
    emit(newState);

    if (network == null || !isFormValid) return;

    try {
      final result = await _saveBeneficiaryUseCase(
        SaveBeneficiaryParams(
          name: state.name.value,
          phone: state.phone.value,
          network: network,
        ),
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: SaveUpdateBeneficiaryStatus.failure,
              message: failure.message,
            ),
          );
        },
        (beneficiary) {
          emit(
            state.copyWith(
              status: SaveUpdateBeneficiaryStatus.success,
              beneficiary: beneficiary,
              message: 'Beneficiary saved successfully',
            ),
          );
          onSaved?.call(beneficiary);
          // Optionally, you can reset the form fields after saving
          emit(SaveUpdateBeneficiaryState.initial());
        },
      );
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: SaveUpdateBeneficiaryStatus.failure,
          message: "Failed to save beneficiary. Please try again.",
        ),
      );

      logE("Error saving beneficiary", error: error, stackTrace: stackTrace);
    }
  }

  Future<void> updateBeneficiary([
    void Function(Beneficiary)? onUpdated,
  ]) async {
    if (state.status.isLoading || isClosed) return;

    final network = state.network;
    final phone = Phone.dirty(state.phone.value);
    final name = FullName.dirty(state.name.value);

    final isFormValid = FormzValid([phone, name]).isFormValid;
    if (network == null || !isFormValid) return;

    if (state.beneficiary == null) {
      emit(
        state.copyWith(
          status: SaveUpdateBeneficiaryStatus.failure,
          message: 'No beneficiary to update',
        ),
      );
      return;
    }

    if (state.beneficiary!.network == network &&
        state.beneficiary!.phone == phone.value &&
        state.beneficiary!.name == name.value) {
      emit(
        state.copyWith(
          status: SaveUpdateBeneficiaryStatus.failure,
          message: 'No changes made to update',
        ),
      );
      return;
    }

    final newState = state.copyWith(
      status: SaveUpdateBeneficiaryStatus.loading,
      phone: phone,
      name: name,
      network: network,
    );
    emit(newState);

    try {
      final result = await _updateBeneficiaryUseCase(
        UpdateBeneficiaryParams(
          id: state.beneficiary?.id ?? '',
          name: name.value.isEmpty ? null : state.name.value,
          phone: state.phone.value.isEmpty ? null : state.phone.value,
          // Ensure network is not null and convert to lowercase
          network: network,
        ),
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: SaveUpdateBeneficiaryStatus.failure,
              message: failure.message,
            ),
          );
        },
        (beneficiary) {
          emit(
            state.copyWith(
              status: SaveUpdateBeneficiaryStatus.success,
              beneficiary: beneficiary,
              message: 'Beneficiary updated successfully',
            ),
          );
          onUpdated?.call(beneficiary);
          // Optionally, you can reset the form fields after saving
          emit(SaveUpdateBeneficiaryState.initial());
        },
      );
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: SaveUpdateBeneficiaryStatus.failure,
          message: "Failed to update beneficiary. Please try again.",
        ),
      );

      logE("Error updating beneficiary", error: error, stackTrace: stackTrace);
    }
  }
}
