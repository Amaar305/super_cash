import 'package:super_cash/features/smile/domain/domain.dart';

import 'smile_plan_model.dart';

class SmilePlanResponseModel extends SmilePlanResponse {
  const SmilePlanResponseModel({required super.plans});

  factory SmilePlanResponseModel.fromJson(Map<String, dynamic> json) {
    final rawPlans = json['plans'] as List<dynamic>? ?? const [];
    return SmilePlanResponseModel(
      plans: rawPlans
          .map((plan) => SmilePlanModel.fromJson(plan as Map<String, dynamic>))
          .toList(),
    );
  }
}
