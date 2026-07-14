import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/kyc.dart';

part 'kyc_home_address_state.dart';

class KycHomeAddressCubit extends Cubit<KycHomeAddressState> {
  final GetAddressUseCase _getAddressUseCase;
  final SubmitAddressUseCase _submitAddressUseCase;

  KycHomeAddressCubit({
    required GetAddressUseCase getAddressUseCase,
    required SubmitAddressUseCase submitAddressUseCase,
  })  : _getAddressUseCase = getAddressUseCase,
        _submitAddressUseCase = submitAddressUseCase,
        super(const KycHomeAddressState.initial());

  Future<void> getAddress() async {
    emit(state.copyWith(status: KycHomeAddressStatus.loading));

    try {
      final res = await _getAddressUseCase(NoParam());
      if (isClosed) return;
      res.fold(
        (l) => emit(state.copyWith(
          status: KycHomeAddressStatus.failure,
          message: l.message,
        )),
        (r) {
          final data = r.data;
          emit(state.copyWith(
            status: KycHomeAddressStatus.success,
            addressData: r,
            message: '',
            country: data?.country.isNotEmpty == true ? data!.country : state.country,
            clearSelectedState: data != null,
            selectedState: data?.state.isNotEmpty == true ? data!.state : null,
            clearSelectedLga: data != null,
            selectedLga: data?.lga.isNotEmpty == true ? data!.lga : null,
            city: data != null && data.city.isNotEmpty
                ? City.pure(data.city)
                : null,
            houseNo: data?.houseNo ?? '',
            address: data != null && data.address.isNotEmpty
                ? HouseAddress.pure(data.address)
                : null,
            postalCode: data?.postalCode ?? '',
          ));
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch address $error', stackTrace: stackTrace);
    }
  }

  void onStateSelected(String? value) {
    if (state.selectedState == value) return;
    emit(state.copyWith(
      clearSelectedState: true,
      selectedState: value,
      clearSelectedStateError: true,
      clearSelectedLga: true,
      selectedLga: null,
    ));
  }

  void onLgaSelected(String? value) {
    emit(state.copyWith(
      clearSelectedLga: true,
      selectedLga: value,
    ));
  }

  void onCityChanged(String value) {
    final prev = state.city;
    final city = prev.invalid ? City.dirty(value) : City.pure(value);
    emit(state.copyWith(city: city));
  }

  void onCityUnfocused() {
    emit(state.copyWith(city: City.dirty(state.city.value)));
  }

  void onHouseNoChanged(String value) {
    emit(state.copyWith(houseNo: value));
  }

  void onAddressChanged(String value) {
    final prev = state.address;
    final address =
        prev.invalid ? HouseAddress.dirty(value) : HouseAddress.pure(value);
    emit(state.copyWith(address: address));
  }

  void onAddressUnfocused() {
    emit(state.copyWith(address: HouseAddress.dirty(state.address.value)));
  }

  void onPostalCodeChanged(String value) {
    emit(state.copyWith(postalCode: value));
  }

  void onCountrySelected(String? value) {
    if (value == null || value == state.country) return;
    emit(state.copyWith(country: value));
  }

  Future<void> submitAddress() async {
    final city = City.dirty(state.city.value);
    final address = HouseAddress.dirty(state.address.value);
    final selectedState = state.selectedState;
    final stateError =
        selectedState == null ? 'State is required' : null;

    final isFormValid =
        FormzValid([city, address]).isFormValid && stateError == null;

    emit(state.copyWith(
      city: city,
      address: address,
      selectedStateError: stateError,
      clearSelectedStateError: stateError == null,
      status: isFormValid ? KycHomeAddressStatus.submitting : null,
    ));

    if (!isFormValid) return;

    try {
      final res = await _submitAddressUseCase(
        KycAddressParams(
          country: state.country,
          state: selectedState!,
          lga: state.selectedLga ?? '',
          city: city.value,
          houseNo: state.houseNo,
          address: address.value,
          postalCode: state.postalCode,
        ),
      );
      if (isClosed) return;

      res.fold(
        (l) => emit(state.copyWith(
          status: KycHomeAddressStatus.failure,
          message: l.message,
        )),
        (r) => emit(state.copyWith(
          status: KycHomeAddressStatus.submitted,
          message: r.message,
        )),
      );
    } catch (error, stackTrace) {
      logE('Failed to submit address $error', stackTrace: stackTrace);
    }
  }
}
