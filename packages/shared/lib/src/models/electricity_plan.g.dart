// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricityPlan _$ElectricityPlanFromJson(Map<String, dynamic> json) =>
    ElectricityPlan(
      plans: (json['plans'] as List<dynamic>)
          .map((e) => Electricity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElectricityPlanToJson(ElectricityPlan instance) =>
    <String, dynamic>{
      'plans': instance.plans,
    };

Electricity _$ElectricityFromJson(Map<String, dynamic> json) => Electricity(
      discoName: json['disco_name'] as String,
      discoId: json['disco_id'] as String,
    );

Map<String, dynamic> _$ElectricityToJson(Electricity instance) =>
    <String, dynamic>{
      'disco_name': instance.discoName,
      'disco_id': instance.discoId,
    };
