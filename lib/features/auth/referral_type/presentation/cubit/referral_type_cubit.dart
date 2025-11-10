import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'referral_type_state.dart';

class ReferralTypeCubit extends Cubit<ReferralTypeState> {
  ReferralTypeCubit() : super(ReferralTypeState.inital());

  void onSelectReferralType(bool isIndividual) {
    emit(state.copyWith(isIndividual: isIndividual));
  }
}
