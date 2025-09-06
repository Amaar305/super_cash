// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'data_plan_model.g.dart';

@JsonSerializable()
class DataPlanResponse {
  const DataPlanResponse({required this.plans});

  const DataPlanResponse.initial() : this(plans: const []);

  factory DataPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$DataPlanResponseFromJson(json);
  final List<DataPlan> plans;

  Map<String, dynamic> toJson() => _$DataPlanResponseToJson(this);
}

@JsonSerializable()
class DataPlan {
  DataPlan({
    required this.id,
    required this.planName,
    required this.planValidity,
    required this.planSize,
    required this.planAmount,
    required this.planBuyAmount,
    required this.planApiAmount,
    required this.planType,
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) =>
      _$DataPlanFromJson(json);
  final String id;

  @JsonKey(name: 'plan_name')
  final String planName;

  @JsonKey(name: 'plan_validity')
  final String planValidity;

  @JsonKey(name: 'plan_size')
  final double planSize;

  @JsonKey(name: 'plan_amount')
  final int planAmount;

  @JsonKey(name: 'plan_buy_amount')
  final int planBuyAmount;

  @JsonKey(name: 'plan_api_amount')
  final int planApiAmount;

  @JsonKey(name: 'plan_type')
  final String planType;

  Map<String, dynamic> toJson() => _$DataPlanToJson(this);
}
