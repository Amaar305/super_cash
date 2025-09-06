// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == HomeStatus.failure;
  bool get isSuccess => this == HomeStatus.success;
  bool get isLoading => this == HomeStatus.loading;
}

@JsonSerializable()
class HomeState extends Equatable {
  final AppUser user;
  final HomeStatus status;
  final String message;
  final bool showBalance;

  const HomeState({
    required this.user,
    required this.status,
    required this.message,
    required this.showBalance,
  });

  const HomeState.initial()
      : this(
          user: AppUser.anonymous,
          status: HomeStatus.initial,
          message: '',
          showBalance: true,
        );

  @override
  List<Object?> get props => [
        user,
        status,
        message,
        showBalance,
      ];

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  HomeState copyWith({
    AppUser? user,
    HomeStatus? status,
    String? message,
    bool? showBalance,
  }) {
    return HomeState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
      showBalance: showBalance ?? this.showBalance,
    );
  }
}
