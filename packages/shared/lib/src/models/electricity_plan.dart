// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'electricity_plan.g.dart';

@JsonSerializable()
class ElectricityPlan {
 const ElectricityPlan({required this.plans});

 const ElectricityPlan.initial():this(plans: const<Electricity>[]);

  factory ElectricityPlan.fromJson(Map<String, dynamic> json) =>
      _$ElectricityPlanFromJson(json);
  final List<Electricity> plans;
  Map<String, dynamic> toJson() => _$ElectricityPlanToJson(this);
}

@JsonSerializable()
class Electricity {
  Electricity({required this.discoName, required this.discoId});

  factory Electricity.fromJson(Map<String, dynamic> json) =>
      _$ElectricityFromJson(json);
  @JsonKey(name: 'disco_name')
  final String discoName;

  @JsonKey(name: 'disco_id')
  final String discoId;
  Map<String, dynamic> toJson() => _$ElectricityToJson(this);
}
