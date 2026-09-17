part of 'smile_plan_selection_cubit.dart';

enum SmilePlanSelectionStatus {
  initial,
  loading,
  loaded,
  failure;

  bool get isLoading => this == SmilePlanSelectionStatus.loading;
  bool get isLoaded => this == SmilePlanSelectionStatus.loaded;
  bool get isError => this == SmilePlanSelectionStatus.failure;
}

class SmilePlanSelectionState extends Equatable {
  final SmilePlanSelectionStatus status;
  final List<SmilePlan> plans;
  final String searchQuery;
  final String message;

  const SmilePlanSelectionState._({
    required this.status,
    required this.plans,
    required this.searchQuery,
    required this.message,
  });

  const SmilePlanSelectionState.initial()
    : this._(
        status: SmilePlanSelectionStatus.initial,
        plans: const [],
        searchQuery: '',
        message: '',
      );

  /// Plans matching [searchQuery], case-insensitively, by name.
  List<SmilePlan> get visiblePlans {
    if (searchQuery.trim().isEmpty) return plans;
    final query = searchQuery.trim().toLowerCase();
    return plans
        .where((plan) => plan.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  List<Object?> get props => [status, plans, searchQuery, message];

  SmilePlanSelectionState copyWith({
    SmilePlanSelectionStatus? status,
    List<SmilePlan>? plans,
    String? searchQuery,
    String? message,
  }) {
    return SmilePlanSelectionState._(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      searchQuery: searchQuery ?? this.searchQuery,
      message: message ?? this.message,
    );
  }
}
