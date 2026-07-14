import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/kyc.dart';

part 'kyc_personal_information_state.dart';

class KycPersonalInformationCubit extends Cubit<KycPersonalInformationState> {
  final GetPersonalInfoUseCase _getPersonalInfoUseCase;
  final SubmitPersonalInfoUseCase _submitPersonalInfoUseCase;

  KycPersonalInformationCubit({
    required GetPersonalInfoUseCase getPersonalInfoUseCase,
    required SubmitPersonalInfoUseCase submitPersonalInfoUseCase,
    required AppCubit appCubit,
  })  : _getPersonalInfoUseCase = getPersonalInfoUseCase,
        _submitPersonalInfoUseCase = submitPersonalInfoUseCase,
        super(KycPersonalInformationState.initial(
          userFirstName: appCubit.state.user?.firstName ?? '',
          userLastName: appCubit.state.user?.lastName ?? '',
        ));

  Future<void> getPersonalInfo() async {
    emit(state.copyWith(status: KycPersonalInformationStatus.loading));

    try {
      final res = await _getPersonalInfoUseCase(NoParam());
      if (isClosed) return;

      res.fold(
        (l) => emit(state.copyWith(
          status: KycPersonalInformationStatus.failure,
          message: l.message,
        )),
        (r) {
          final data = r.data;
          emit(state.copyWith(
            status: KycPersonalInformationStatus.success,
            personalInfoResponse: r,
            firstName: data != null && data.firstName.isNotEmpty
                ? FirstName.pure(data.firstName)
                : state.firstName,
            lastName: data != null && data.lastName.isNotEmpty
                ? LastName.pure(data.lastName)
                : state.lastName,
            middleName: data?.middleName ?? state.middleName,
            dateOfBirth: data?.dateOfBirth ?? '',
            clearGender: data != null,
            gender: data?.gender,
            message: '',
          ));
        },
      );
    } catch (error, stackTrace) {
      logI('Failed to fetch personal info $error', stackTrace: stackTrace);
    }
  }

  void onFirstNameChanged(String value) {
    final prev = state.firstName;
    final firstName =
        prev.invalid ? FirstName.dirty(value) : FirstName.pure(value);
    emit(state.copyWith(firstName: firstName));
  }

  void onFirstNameUnfocused() {
    emit(state.copyWith(firstName: FirstName.dirty(state.firstName.value)));
  }

  void onLastNameChanged(String value) {
    final prev = state.lastName;
    final lastName =
        prev.invalid ? LastName.dirty(value) : LastName.pure(value);
    emit(state.copyWith(lastName: lastName));
  }

  void onLastNameUnfocused() {
    emit(state.copyWith(lastName: LastName.dirty(state.lastName.value)));
  }

  void onMiddleNameChanged(String value) {
    emit(state.copyWith(middleName: value));
  }

  void onDateOfBirthSelected(DateTime date) {
    final formatted =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    emit(state.copyWith(
      dateOfBirth: formatted,
      clearDateOfBirthError: true,
    ));
  }

  void onGenderChanged(String? value) {
    emit(state.copyWith(clearGender: true, gender: value));
  }

  Future<void> submitPersonalInfo() async {
    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    final dobError =
        state.dateOfBirth.isEmpty ? 'Date of birth is required' : null;

    final isFormValid =
        FormzValid([firstName, lastName]).isFormValid && dobError == null;

    emit(state.copyWith(
      firstName: firstName,
      lastName: lastName,
      dateOfBirthError: dobError,
      status: isFormValid ? KycPersonalInformationStatus.submitting : null,
    ));

    if (!isFormValid) return;

    try {
      final res = await _submitPersonalInfoUseCase(
        KycPersonalInfoParams(
          firstName: firstName.value,
          lastName: lastName.value,
          middleName: state.middleName,
          dateOfBirth: state.dateOfBirth,
          gender: state.gender,
        ),
      );
      if (isClosed) return;

      res.fold(
        (l) => emit(state.copyWith(
          status: KycPersonalInformationStatus.failure,
          message: l.message,
        )),
        (r) => emit(state.copyWith(
          status: KycPersonalInformationStatus.submitted,
          message: r.message,
        )),
      );
    } catch (error, stackTrace) {
      logI('Failed to submit personal info $error', stackTrace: stackTrace);
    }
  }
}
