import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/referal/referal.dart';

part 'referal_state.dart';

typedef ReferralClaimedCallBack = void Function(ReferralResult);

class ReferalCubit extends Cubit<ReferalState> {
  final FetchMyReferralsUseCase _fetchMyReferralsUseCase;
  final ClaimMyRewardsUseCase _claimMyRewardsUseCase;
  ReferalCubit({
    required FetchMyReferralsUseCase fetchMyRerralsUseCase,
    required ClaimMyRewardsUseCase claimMyRewardsUseCase,
  }) : _claimMyRewardsUseCase = claimMyRewardsUseCase,
       _fetchMyReferralsUseCase = fetchMyRerralsUseCase,
       super(ReferalState.initial());

  void changeReferralType(bool type) {
    if (type == state.showReferralList || state.status.isLoading) {
      return;
    }
    emit(state.copyWith(showReferralList: type));
  }

  Future<void> fetchMyReferrals() async {
    if (isClosed || state.status.isLoading) return;

    try {
      emit(state.copyWith(status: ReferalStatus.loading, message: ''));
      final res = await _fetchMyReferralsUseCase(NoParam());
      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ReferalStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: ReferalStatus.success,
              message: 'Successfully fetched referrals.',
              referralUsers: success,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch referral data $error', stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: ReferalStatus.failure,
          message: 'Failed to fetch referral data',
        ),
      );
    }
  }

  Future<void> claimMyReward([ReferralClaimedCallBack? onSuccess]) async {
    if (isClosed || state.status.isLoading) return;

    try {
      emit(state.copyWith(status: ReferalStatus.loading, message: ''));
      final res = await _claimMyRewardsUseCase(
        ClaimMyRewardsParams(refereeIds: [], idempotencyKey: ''),
      );
      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ReferalStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: ReferalStatus.success,
              message: 'Successfully claimed referral rewards.',
              referralResult: success,
            ),
          );
          onSuccess?.call(success);
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to claim referral reward $error', stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ReferalStatus.failure,
          message: 'Failed to claim referral reward',
        ),
      );
    }
  }
}
