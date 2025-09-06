part of 'add_fund_cubit.dart';

enum AddFundStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == AddFundStatus.initial;
  bool get isLoading => this == AddFundStatus.loading;
  bool get isSuccess => this == AddFundStatus.success;
  bool get isFailure => this == AddFundStatus.failure;
}

class AddFundState extends Equatable {
  final AddFundStatus status;
  final int activeFundingMethod;
  final String message;
  final Bvn bvn;

  const AddFundState._({
    required this.status,
    required this.activeFundingMethod,
    required this.message,
    required this.bvn,
  });

  const AddFundState.initial()
      : this._(
          status: AddFundStatus.initial,
          activeFundingMethod: 0,
          message: '',
          bvn: const Bvn.pure(),
        );

  @override
  List<Object> get props => [
        status,
        activeFundingMethod,
        message,
        bvn,
      ];

  AddFundState copyWith({
    AddFundStatus? status,
    int? activeFundingMethod,
    String? message,
    Bvn? bvn,
  }) {
    return AddFundState._(
      status: status ?? this.status,
      activeFundingMethod: activeFundingMethod ?? this.activeFundingMethod,
      message: message ?? this.message,
      bvn: bvn ?? this.bvn,
    );
  }
}
