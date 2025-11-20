import 'dart:io';

import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../upgrade_tier.dart';

part 'upgrade_tier_state.dart';

class UpgradeTierCubit extends Cubit<UpgradeTierState> {
  final UpgradeAccountUseCase _upgradeAccountUseCase;
  final CheckUpgradeStatusUseCase _checkUpgradeStatusUseCase;
  final AppCubit _appBloc;

  UpgradeTierCubit({
    required UpgradeAccountUseCase upgradeAccountUseCase,
    required CheckUpgradeStatusUseCase checkUpgradeStatusUseCase,
    required AppCubit appBloc,
  }) : _upgradeAccountUseCase = upgradeAccountUseCase,
       _checkUpgradeStatusUseCase = checkUpgradeStatusUseCase,
       _appBloc = appBloc,
       super(UpgradeTierState.inital(currentUser: appBloc.state.user??AppUser.anonymous));

  void nextStep() => emit(state.copyWith(currentStep: state.currentStep + 1));

  void previousStep() {
    if (state.currentStep < 1) return;
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void jumpToStep(int step) => emit(state.copyWith(currentStep: step));

  /// Email value was changed, triggering new changes in state.
  void onEmailChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final shouldValidate = previousEmailState.invalid;
    final newEmailState = shouldValidate
        ? Email.dirty(newValue)
        : Email.pure(newValue);

    final newScreenState = state.copyWith(email: newEmailState);

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

  /// [FirstName] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [FirstName] and emmiting new [FirstName]
  /// validation state.
  void onFirstNameChanged(String newValue) {
    final previousScreenState = state;
    final previousFirstNameState = previousScreenState.firstName;
    final shouldValidate = previousFirstNameState.invalid;
    final newFullNameState = shouldValidate
        ? FirstName.dirty(newValue)
        : FirstName.pure(newValue);

    final newScreenState = state.copyWith(firstName: newFullNameState);

    emit(newScreenState);
  }

  /// [FirstName] field was unfocused, here is checking if previous state with
  /// [FirstName] was valid, in order to indicate it in state after unfocus.
  void onFirstNameUnfocused() {
    final previousScreenState = state;
    final previousFirstNameState = previousScreenState.firstName;
    final previousFullNameValue = previousFirstNameState.value;

    final newFullNameState = FirstName.dirty(previousFullNameValue);
    final newScreenState = previousScreenState.copyWith(
      firstName: newFullNameState,
    );
    emit(newScreenState);
  }

  /// [LastName] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
  void onLastNameChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.lastName;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? LastName.dirty(newValue)
        : LastName.pure(newValue);

    final newScreenState = state.copyWith(lastName: newSurnameState);

    emit(newScreenState);
  }

  void onLastNameUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.lastName;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = LastName.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      lastName: newUsernameState,
    );
    emit(newScreenState);
  }

  /// [Phone] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
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

  void checkDetails() {
    final email = Email.dirty(state.email.value);

    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    final phone = Phone.dirty(state.phone.value);
    final isFormValid = FormzValid([
      email,
      firstName,
      lastName,
      phone,
    ]).isFormValid;

    final newState = state.copyWith(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      status: isFormValid ? UpgradeTierStatus.inProgress : null,
    );

    emit(newState);

    if (!isFormValid) return;
    nextStep();
  }

  ///Address Section
  void onSelectCountry(String? country) {
    if (state.selectedCountry == country) return;

    emit(state.copyWith(selectedCountry: country, selectedCountryErrMsg: ''));
  }

  void onSelectCountryFocused() {
    final previousScreenState = state;
    final previousCountryState = previousScreenState.selectedCountry;

    final shouldValidate = previousCountryState != null;
    if (shouldValidate) return;
    final newScreenState = previousScreenState.copyWith(
      selectedCountryErrMsg: 'This field is required',
    );

    emit(newScreenState);
  }

  void onSelectState(String? city) {
    if (state.selectedState == city) return;

    emit(state.copyWith(selectedState: city, selectedStateErrMsg: ''));
  }

  void onSelectStateFocused() {
    final previousScreenState = state;
    final previousStateState = previousScreenState.selectedState;

    final shouldValidate = previousStateState != null;
    if (shouldValidate) return;
    final newScreenState = previousScreenState.copyWith(
      selectedStateErrMsg: 'This field is required',
    );

    emit(newScreenState);
  }

  void onCityChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.city;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? City.dirty(newValue)
        : City.pure(newValue);

    final newScreenState = state.copyWith(city: newSurnameState);

    emit(newScreenState);
  }

  void onCityUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.city;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = City.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(city: newUsernameState);
    emit(newScreenState);
  }

  void onPostalCodeChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.postalCode;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? PostalCode.dirty(newValue)
        : PostalCode.pure(newValue);

    final newScreenState = state.copyWith(postalCode: newSurnameState);

    emit(newScreenState);
  }

  void onPostalCodeUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.postalCode;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = PostalCode.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      postalCode: newUsernameState,
    );
    emit(newScreenState);
  }

  void onHouseNumberChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.houseNumber;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? HouseNumber.dirty(newValue)
        : HouseNumber.pure(newValue);

    final newScreenState = state.copyWith(houseNumber: newSurnameState);

    emit(newScreenState);
  }

  void onHouseNumberUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.houseNumber;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = HouseNumber.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      houseNumber: newUsernameState,
    );
    emit(newScreenState);
  }

  void onHouseAddressChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.houseAddress;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? HouseAddress.dirty(newValue)
        : HouseAddress.pure(newValue);

    final newScreenState = state.copyWith(houseAddress: newSurnameState);

    emit(newScreenState);
  }

  void onHouseAddressUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.houseAddress;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = HouseAddress.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      houseAddress: newUsernameState,
    );
    emit(newScreenState);
  }

  static final errorMsg = 'This field is required';

  void checkAddress() {
    final selectedCountry = state.selectedCountry;
    final selectedState = state.selectedState;

    final checkSelectedDropdownField =
        selectedCountry != null && selectedState != null;
    final city = City.dirty(state.city.value);
    final postalCode = PostalCode.dirty(state.postalCode.value);
    final houseNumber = HouseNumber.dirty(state.houseNumber.value);
    final houseAddress = HouseAddress.dirty(state.houseAddress.value);

    final isFormValid =
        FormzValid([city, postalCode, houseNumber, houseAddress]).isFormValid &&
        checkSelectedDropdownField;

    final newState = state.copyWith(
      city: city,
      postalCode: postalCode,
      houseNumber: houseNumber,
      houseAddress: houseAddress,
      selectedCountry: selectedCountry,
      selectedState: selectedState,
      selectedCountryErrMsg: selectedCountry == null ? errorMsg : null,
      selectedStateErrMsg: selectedState == null ? errorMsg : null,
      status: isFormValid ? UpgradeTierStatus.inProgress : null,
    );

    emit(newState);

    if (!isFormValid) return;
    nextStep();
  }

  void onIdTypeSelected(String? newId) {
    if (state.selectedIdType == newId) return;

    emit(state.copyWith(selectedIdType: newId));
  }

  void onBvnChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.bvn;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Bvn.dirty(newValue)
        : Bvn.pure(newValue);

    final newScreenState = state.copyWith(bvn: newSurnameState);

    emit(newScreenState);
  }

  void onBvnUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.bvn;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Bvn.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(bvn: newUsernameState);
    emit(newScreenState);
  }

  void onSelfieTake(File? selfie) {
    emit(state.copyWith(selfie: selfie));
  }

  void onSubmit({void Function(dynamic)? onSuccess}) async {
    final bvn = Bvn.dirty(state.bvn.value);
    final selfie = state.selfie;
    final selectedCountry = state.selectedCountry;
    final selectedState = state.selectedState;

    final checkSelectedDropdownField =
        selectedCountry != null && selectedState != null;
    final city = City.dirty(state.city.value);
    final postalCode = PostalCode.dirty(state.postalCode.value);
    final houseNumber = HouseNumber.dirty(state.houseNumber.value);
    final houseAddress = HouseAddress.dirty(state.houseAddress.value);
    final email = Email.dirty(state.email.value);

    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    final phone = Phone.dirty(state.phone.value);
    final isFormValid =
        FormzValid([
          bvn,
          city,
          postalCode,
          houseAddress,
          houseNumber,
          email,
          firstName,
          lastName,
          phone,
        ]).isFormValid &&
        selfie != null &&
        checkSelectedDropdownField;

    final newState = state.copyWith(
      bvn: bvn,
      selfie: selfie,
      selfieImageErrMsg: selfie == null ? errorMsg : null,
      city: city,
      postalCode: postalCode,
      houseNumber: houseNumber,
      houseAddress: houseAddress,
      selectedCountry: selectedCountry,
      selectedState: selectedState,
      selectedCountryErrMsg: selectedCountry == null ? errorMsg : null,
      selectedStateErrMsg: selectedState == null ? errorMsg : null,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      status: isFormValid ? UpgradeTierStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    final UpgradeAccountProps props = UpgradeAccountProps(
      firstName: firstName.value,
      lastName: lastName.value,
      email: email.value,
      phone: phone.value,
      country: selectedCountry,
      state: selectedState,
      city: city.value,
      houseNumber: houseNumber.value,
      houseAddress: houseAddress.value,
      postalCode: postalCode.value,
      idType: state.selectedIdType,
      bvnNumber: bvn.value,
      selfieFile: selfie,
    );

    final res = await _upgradeAccountUseCase(props);

    res.fold(
      (l) => emit(
        state.copyWith(status: UpgradeTierStatus.failure, message: l.message),
        //TODO Check suspension status
      ),
      (r) {
        emit(state.copyWith(status: UpgradeTierStatus.success));
        onSuccess?.call(r);
      },
    );
  }

  void onUpgradeConfirm() async {
    if (isClosed) return;
    try {
      emit(state.copyWith(status: UpgradeTierStatus.loading));
      final res = await _checkUpgradeStatusUseCase(NoParam());

      res.fold(
        (l) => emit(
          state.copyWith(status: UpgradeTierStatus.failure, message: l.message),
        ),
        (r) {
          emit(state.copyWith(status: UpgradeTierStatus.upgraded));
          // Update user model

          final user = _appBloc.state.user??AppUser.anonymous;
          if (user != AppUser.anonymous) {
            final newUser = user.copyWith(isKycVerified: true);
            _appBloc.updateUser(newUser);
          } else {
            logE("User is anonymous, cannot update user model.");
            // Optional: log or handle the null case explicitly
          }
        },
      );
    } catch (e, stackTrace) {
      logE("Upgrade error: $e\n$stackTrace");
      emit(
        state.copyWith(
          status: UpgradeTierStatus.failure,
          message: "Fail to upgrade account.",
        ),
      );
    }
  }
}
