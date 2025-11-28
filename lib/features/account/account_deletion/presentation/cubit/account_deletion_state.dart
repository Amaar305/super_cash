part of 'account_deletion_cubit.dart';

enum AccountDeletionStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == AccountDeletionStatus.initial;
  bool get isLoading => this == AccountDeletionStatus.loading;
  bool get isSuccess => this == AccountDeletionStatus.success;
  bool get isFailure => this == AccountDeletionStatus.failure;
}

class AccountDeletionState extends Equatable {
  final AccountDeletionStatus status;
  final String reason;
  final String message;
  final String? reasonError;

  const AccountDeletionState._({
    required this.status,
    required this.reason,
    required this.message,
    this.reasonError,
  });

  const AccountDeletionState.initial()
      : this._(
          status: AccountDeletionStatus.initial,
          reason: '',
          message: '',
        );

  AccountDeletionState copyWith({
    AccountDeletionStatus? status,
    String? reason,
    String? message,
    String? reasonError,
  }) {
    return AccountDeletionState._(
      status: status ?? this.status,
      reason: reason ?? this.reason,
      message: message ?? this.message,
      reasonError: reasonError ?? this.reasonError,
    );
  }

  @override
  List<Object?> get props => [status, reason, message, reasonError];
}
