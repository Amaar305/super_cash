part of 'transfer_cubit.dart';

enum TransferStatus {
  initial,
  loading,
  validated,
  success,
  failure;

  bool get isLoading => this == TransferStatus.loading;
  bool get isInitial => this == TransferStatus.initial;
  bool get isError => this == TransferStatus.failure;
  bool get isValidated => this == TransferStatus.validated;
  bool get isSuccess => this == TransferStatus.success;
}

class TransferState extends Equatable {
  final TransferStatus status;
  final Account account;
  final Amount amount;
  final String message;
  final String? selectedBank;
  final String? selectedBankErrorMsg;
  final ValidatedBankDetail? bankDetail;

  const TransferState._({
    required this.status,
    required this.account,
    required this.amount,
    required this.message,
    required this.selectedBank,
    required this.selectedBankErrorMsg,
    required this.bankDetail,
  });

  const TransferState.initial()
      : this._(
          status: TransferStatus.initial,
          account: const Account.pure(),
          amount: const Amount.pure(),
          message: '',
          selectedBank: null,
          selectedBankErrorMsg: null,
          bankDetail: null,
        );
  @override
  List<Object?> get props => [
        status,
        account,
        amount,
        message,
        selectedBank,
        selectedBankErrorMsg,
        bankDetail,
      ];

  TransferState copyWith({
    TransferStatus? status,
    Account? account,
    Amount? amount,
    String? message,
    String? selectedBank,
    String? selectedBankErrorMsg,
    ValidatedBankDetail? bankDetail,
  }) {
    return TransferState._(
      status: status ?? this.status,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      message: message ?? this.message,
      selectedBank: selectedBank ?? this.selectedBank,
      selectedBankErrorMsg: selectedBankErrorMsg ?? this.selectedBankErrorMsg,
      bankDetail: bankDetail ?? this.bankDetail,
    );
  }
}

class ValidatedBankDetail {
  final String bankName;
  final String accountName;
  final String accountNumber;

  const ValidatedBankDetail({
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  });
}
