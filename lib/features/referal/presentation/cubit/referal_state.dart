// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'referal_cubit.dart';

enum ReferalStatus {
  initial,
  loading,
  success,
  failure;

  bool get isFailure => this == ReferalStatus.failure;
  bool get isLoading => this == ReferalStatus.loading;
  bool get isSuccess => this == ReferalStatus.success;
}

class ReferalState extends Equatable {
  final ReferalStatus status;
  final String message;
  final List<ReferralUser> referralUsers;
  final bool showReferralList;

  const ReferalState({
    required this.status,
    required this.message,
    required this.referralUsers,
    required this.showReferralList,
  });

  const ReferalState.initial()
    : this(
        message: '',
        status: ReferalStatus.initial,
        referralUsers: const [],
        showReferralList: true,
      );

  ///Total reward counts
  int get totalCount => referralUsers.length;

  ///Total active count
  int get totalActive => referralUsers.filter((t) => t.active).length;

  ///Total verified counts
  int get totalVerified => referralUsers.filter((t) => t.active).length;

  ///Total amounts
  double get totalAmount {
    double d = 0;

    for (var referral in referralUsers) {
      d += referral.rewardAmount;
    }

    return d;
  }

  @override
  List<Object> get props => [status, message, referralUsers, showReferralList];

  ReferalState copyWith({
    ReferalStatus? status,
    String? message,
    List<ReferralUser>? referralUsers,
    bool? showReferralList,
  }) {
    return ReferalState(
      status: status ?? this.status,
      message: message ?? this.message,
      referralUsers: referralUsers ?? this.referralUsers,
      showReferralList: showReferralList ?? this.showReferralList,
    );
  }
}
