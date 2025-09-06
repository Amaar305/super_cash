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

  const ReferalState({
    required this.status,
    required this.message,
    required this.referralUsers,
  });

  const ReferalState.initial()
    : this(message: '', status: ReferalStatus.initial, referralUsers: const []);

  @override
  List<Object> get props => [status, message, referralUsers];

  ReferalState copyWith({
    ReferalStatus? status,
    String? message,
    List<ReferralUser>? referralUsers,
  }) {
    return ReferalState(
      status: status ?? this.status,
      message: message ?? this.message,
      referralUsers: referralUsers ?? this.referralUsers,
    );
  }
}
