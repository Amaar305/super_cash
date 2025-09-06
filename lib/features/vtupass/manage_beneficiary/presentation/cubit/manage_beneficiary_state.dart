// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_beneficiary_cubit.dart';

enum ManageBeneficiaryStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == ManageBeneficiaryStatus.initial;
  bool get isLoading => this == ManageBeneficiaryStatus.loading;
  bool get isSuccess => this == ManageBeneficiaryStatus.success;
  bool get isFailure => this == ManageBeneficiaryStatus.failure;
}

class ManageBeneficiaryState extends Equatable {
  const ManageBeneficiaryState({
    required this.status,
    required this.message,
    required this.beneficiaries,
    this.paginationMeta,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.nextPageUrl,
  });

  const ManageBeneficiaryState.initial()
      : this(
          status: ManageBeneficiaryStatus.initial,
          message: '',
          beneficiaries: const [],
          currentPage: 1,
        );

  final ManageBeneficiaryStatus status;
  final String message;
  final List<Beneficiary> beneficiaries;
  final PaginationMeta? paginationMeta;
  final bool hasReachedMax;
  final int currentPage;
  final String? nextPageUrl;

  @override
  List<Object?> get props => [
        status,
        message,
        beneficiaries,
        paginationMeta,
        hasReachedMax,
        currentPage,
        nextPageUrl,
      ];

  ManageBeneficiaryState copyWith({
    ManageBeneficiaryStatus? status,
    String? message,
    List<Beneficiary>? beneficiaries,
    PaginationMeta? paginationMeta,
    bool? hasReachedMax,
    int? currentPage,
    String? nextPageUrl,
  }) {
    return ManageBeneficiaryState(
      status: status ?? this.status,
      message: message ?? this.message,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      paginationMeta: paginationMeta ?? this.paginationMeta,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }
}
