part of 'cash_giveaway_cubit.dart';

enum CashGiveawayStatus {
  initial,
  loading,
  loaded,
  loadedBanks,
  validatedBank,
  claimed,
  finished,
  failure;

  bool get isLoading => this == CashGiveawayStatus.loading;
  bool get isClaimed => this == CashGiveawayStatus.claimed;
  bool get isValidated => this == CashGiveawayStatus.validatedBank;

  bool get isFailure => this == CashGiveawayStatus.failure;
}

class CashGiveawayState extends Equatable {
  final CashGiveawayStatus status;
  final List<CashGiveawayItem> giveaways;
  final String message;
  final Account accountNumber;
  final List<Bank> bankList;
  final Bank? selectedBank;
  final ValidatedBank? bankValidationResult;

  const CashGiveawayState._({
    required this.status,
    required this.giveaways,
    required this.message,
    required this.accountNumber,
    required this.bankList,
    required this.selectedBank,
    required this.bankValidationResult,
  });

  const CashGiveawayState.initial()
    : this._(
        status: CashGiveawayStatus.initial,
        giveaways: const [],
        message: '',
        accountNumber: const Account.pure(),
        bankList: const [],
        selectedBank: null,
        bankValidationResult: null,
      );

  CashGiveawayState copyWith({
    CashGiveawayStatus? status,
    List<CashGiveawayItem>? giveaways,
    String? message,
    Account? accountNumber,
    List<Bank>? bankList,
    Bank? selectedBank,
    ValidatedBank? bankValidationResult,
  }) {
    return CashGiveawayState._(
      status: status ?? this.status,
      giveaways: giveaways ?? this.giveaways,
      message: message ?? this.message,
      accountNumber: accountNumber ?? this.accountNumber,
      bankList: bankList ?? this.bankList,
      selectedBank: selectedBank ?? this.selectedBank,
      bankValidationResult: bankValidationResult ?? this.bankValidationResult,
    );
  }

  int get totalCash => giveaways.fold(
    1,
    (previousValue, item) => (item.amount * item.cashQuantity).toInt(),
  );

  int get availableCash => giveaways.fold(
    0,
    (previousValue, item) =>
        previousValue + (item.amount * item.cashQuantityRemaining).toInt(),
  );

  double get remainingPercent {
    var total = 0.0;
    var remaining = 0.0;

    for (final item in giveaways) {
      final amount = item.amount;
      total += amount * item.cashQuantity;
      remaining += amount * item.cashQuantityRemaining;
    }

    return total == 0 ? 0 : remaining / total;
  }

  @override
  List<Object?> get props => [
    status,
    giveaways,
    message,
    accountNumber,
    bankList,
    selectedBank,
    bankValidationResult,
  ];
}
