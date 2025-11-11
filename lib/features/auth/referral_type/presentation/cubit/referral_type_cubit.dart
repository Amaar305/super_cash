import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/auth/referral_type/domain/domain.dart';

part 'referral_type_state.dart';

class ReferralTypeCubit extends Cubit<ReferralTypeState> {
  final FetchCompainsUseCase _fetchCompainsUseCase;
  final EnrolCompainUseCase _enrolCompainUseCase;
  ReferralTypeCubit({
    required FetchCompainsUseCase fetchCompainsUseCase,
    required EnrolCompainUseCase enrolCompainUseCase,
  }) : _fetchCompainsUseCase = fetchCompainsUseCase,
       _enrolCompainUseCase = enrolCompainUseCase,
       super(ReferralTypeState.inital());

  void onSelectReferralType(bool isIndividual) {
    emit(state.copyWith(isIndividual: isIndividual));
  }

  Future<void> fetchCampaigns() async {
    if (isClosed || state.status.isLoading) return;

    emit(state.copyWith(status: ReferralTypeStatus.loading, message: ''));

    try {
      final result = await _fetchCompainsUseCase(NoParam());

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ReferralTypeStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: ReferralTypeStatus.success,
              message: 'Campaigns fetched successfully.',
              referralTypeResult: success,
            ),
          );
        },
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ReferralTypeStatus.failure,
          message: 'Failed to fetch campaigns.',
        ),
      );
    }
  }

  Future<void> onEnroll(
    void Function(ReferralTypeEnrolResult result) onEnrolled,
  ) async {
    final selected = state.selectedCampaign;
    if (selected == null || selected.id.isEmpty || state.status.isLoading) {
      return;
    }

    emit(state.copyWith(status: ReferralTypeStatus.loading, message: ''));

    try {
      final result = await _enrolCompainUseCase(
        EnrolCompainParams(compainId: selected.id),
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ReferralTypeStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: ReferralTypeStatus.success,
              message: 'Successfully enrolled in ${success.compainName}.',
            ),
          );

          onEnrolled(success);
        },
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ReferralTypeStatus.failure,
          message: 'Failed to enroll into campaign.',
        ),
      );
    }
  }

  void onCampaignSelected(ReferralTypeModel campaign) {
    if (state.selectedCampaign?.id == campaign.id) return;
    emit(state.copyWith(selectedCampaign: campaign));
  }

  void changeTermsCondition() =>
      emit(state.copyWith(termsContidition: !state.termsContidition));
}
