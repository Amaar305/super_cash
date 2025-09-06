import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../add_fund.dart';

part 'add_fund_state.dart';

class AddFundCubit extends Cubit<AddFundState> {
  AddFundCubit({
    required GenerateAccountUseCase generateAccountUseCase,
  })  : _generateAccountUseCase = generateAccountUseCase,
        super(AddFundState.initial());

  final GenerateAccountUseCase _generateAccountUseCase;

  void resetState() => emit(AddFundState.initial());

  void onFundingMethodChanged(int index) =>
      emit(state.copyWith(activeFundingMethod: index));

  void onBvnUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.bvn;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Bvn.dirty(
      previousUsernameValue,
    );
    final newScreenState = previousScreenState.copyWith(
      bvn: newUsernameState,
    );
    emit(newScreenState);
  }

  void onBvnChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.bvn;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Bvn.dirty(
            newValue,
          )
        : Bvn.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      bvn: newSurnameState,
    );

    emit(newScreenState);
  }

  Future<void> generateAccount([void Function(String)? onSuccess]) async {
    final bvn = Bvn.dirty(state.bvn.value);
    final isFormValid = FormzValid([
      bvn,
    ]).isFormValid;

    final newState = state.copyWith(
      bvn: bvn,
      status: isFormValid ? AddFundStatus.loading : AddFundStatus.failure,
      activeFundingMethod: state.activeFundingMethod,
    );
    emit(newState);
    emit(newState);

    if (!isFormValid) return;
    try {
      final res = await _generateAccountUseCase(
        GenerateAccountParams(bvn: bvn.value),
      );

      res.fold(
          (failure) => emit(newState.copyWith(
                status: AddFundStatus.failure,
                message: failure.message,
              )), (success) {
        emit(newState.copyWith(
          status: AddFundStatus.success,
          message: 'Account generated successfully',
        ));
        onSuccess?.call(success);
        // Optionally, you can reset the form or navigate to another screen
        // emit(AddFundState.initial());
      });
    } catch (error, stackTrace) {
      emit(newState.copyWith(
        status: AddFundStatus.failure,
        message: error.toString(),
      ));
      logE('Error generating account', error: error, stackTrace: stackTrace);
      return;
    }
  }
}
