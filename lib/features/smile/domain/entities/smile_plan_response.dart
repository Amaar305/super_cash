import 'package:equatable/equatable.dart';

import 'smile_plan.dart';

class SmilePlanResponse extends Equatable {
  final List<SmilePlan> plans;

  const SmilePlanResponse({required this.plans});

  const SmilePlanResponse.initial() : this(plans: const []);

  @override
  List<Object?> get props => [plans];
}
