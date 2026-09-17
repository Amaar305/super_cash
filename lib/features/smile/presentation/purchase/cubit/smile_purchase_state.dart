part of 'smile_purchase_cubit.dart';

enum SmilePurchaseStatus {
  initial,
  loading,
  verified,
  success,
  failure;

  bool get isLoading => this == SmilePurchaseStatus.loading;
  bool get isError => this == SmilePurchaseStatus.failure;
  bool get isSuccess => this == SmilePurchaseStatus.success;
}

class SmilePurchaseState extends Equatable {
  /// Chosen on the previous page; fixed for this cubit's lifetime.
  final SmilePlan plan;
  final SmilePurchaseStatus status;
  final String message;
  final Email email;
  final Phone phone;
  final String? customerName;
  final List<SmileAccount> accounts;
  final SmileAccount? selectedAccount;

  const SmilePurchaseState._({
    required this.plan,
    required this.status,
    required this.message,
    required this.email,
    required this.phone,
    required this.customerName,
    required this.accounts,
    required this.selectedAccount,
  });

  factory SmilePurchaseState.initial(SmilePlan plan) => SmilePurchaseState._(
    plan: plan,
    status: SmilePurchaseStatus.initial,
    message: '',
    email: const Email.pure(),
    phone: const Phone.pure(),
    customerName: null,
    accounts: const [],
    selectedAccount: null,
  );

  // Verification succeeds as soon as VTpass returns linked accounts; which
  // one gets funded is a separate choice (auto-picked only when there's a
  // single account) enforced later, at purchase time.
  bool get isVerified => accounts.isNotEmpty;

  @override
  List<Object?> get props => [
    plan,
    status,
    message,
    email,
    phone,
    customerName,
    accounts,
    selectedAccount,
  ];

  SmilePurchaseState copyWith({
    SmilePurchaseStatus? status,
    String? message,
    Email? email,
    Phone? phone,
    String? customerName,
    List<SmileAccount>? accounts,
    SmileAccount? selectedAccount,
    bool forceVerificationClear = false,
  }) {
    return SmilePurchaseState._(
      plan: plan,
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      customerName: forceVerificationClear
          ? null
          : customerName ?? this.customerName,
      accounts: forceVerificationClear ? const [] : accounts ?? this.accounts,
      selectedAccount: forceVerificationClear
          ? null
          : selectedAccount ?? this.selectedAccount,
    );
  }
}
