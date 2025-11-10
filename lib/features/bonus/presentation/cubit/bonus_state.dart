part of 'bonus_cubit.dart';

enum BonusStatus {
  initial,
  loading,
  loaded,
  validated,
  transferred,
  withdrawn,
  failure;

  bool get isError => this == BonusStatus.failure;
  bool get isLoading => this == BonusStatus.loading;
  bool get isLoaded => this == BonusStatus.loaded;
  bool get isValidated => this == BonusStatus.validated;
  bool get isWithdrawn => this == BonusStatus.withdrawn;
  bool get isTransferred => this == BonusStatus.transferred;
}

class BonusState extends Equatable {
  final BonusStatus status;
  final String message;
  final bool isBonusWithdrawn;
  final Amount amount;
  final FullName accountName;
  final Account accountNumber;
  final List<Bank> bankList;
  final Bank? selectedBank;
  final ValidatedBank? bankValidationResult;

  const BonusState._({
    required this.status,
    required this.message,
    required this.isBonusWithdrawn,
    required this.amount,
    required this.accountName,
    required this.accountNumber,
    this.bankList = const [],
    this.selectedBank,
    this.bankValidationResult,
  });

  const BonusState.initial()
    : this._(
        status: BonusStatus.initial,
        message: '',
        isBonusWithdrawn: true,
        amount: const Amount.pure(),
        accountName: const FullName.pure(),
        accountNumber: const Account.pure(),
      );

  @override
  List<Object?> get props => [
    status,
    message,
    isBonusWithdrawn,
    amount,
    accountName,
    accountNumber,
    bankList,
    selectedBank,
    bankValidationResult,
  ];

  BonusState copyWith({
    BonusStatus? status,
    String? message,
    bool? isBonusWithdrawn,
    Amount? amount,
    FullName? accountName,
    Account? accountNumber,
    List<Bank>? bankList,
    Bank? selectedBank,
    ValidatedBank? bankValidationResult,
  }) {
    return BonusState._(
      status: status ?? this.status,
      message: message ?? this.message,
      isBonusWithdrawn: isBonusWithdrawn ?? this.isBonusWithdrawn,
      amount: amount ?? this.amount,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankList: bankList ?? this.bankList,
      selectedBank: selectedBank ?? this.selectedBank,
      bankValidationResult: bankValidationResult ?? this.bankValidationResult,
    );
  }
}
