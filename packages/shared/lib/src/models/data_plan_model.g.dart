// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPlanResponse _$DataPlanResponseFromJson(Map<String, dynamic> json) =>
    DataPlanResponse(
      plans: (json['plans'] as List<dynamic>)
          .map((e) => DataPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPlanResponseToJson(DataPlanResponse instance) =>
    <String, dynamic>{
      'plans': instance.plans,
    };

DataPlan _$DataPlanFromJson(Map<String, dynamic> json) => DataPlan(
      id: json['id'] as String,
      planName: json['plan_name'] as String,
      planValidity: json['plan_validity'] as String,
      planSize: (json['plan_size'] as num).toDouble(),
      planAmount: (json['plan_amount'] as num).toInt(),
      planBuyAmount: (json['plan_buy_amount'] as num).toInt(),
      planApiAmount: (json['plan_api_amount'] as num).toInt(),
      planType: json['plan_type'] as String,
    );

Map<String, dynamic> _$DataPlanToJson(DataPlan instance) => <String, dynamic>{
      'id': instance.id,
      'plan_name': instance.planName,
      'plan_validity': instance.planValidity,
      'plan_size': instance.planSize,
      'plan_amount': instance.planAmount,
      'plan_buy_amount': instance.planBuyAmount,
      'plan_api_amount': instance.planApiAmount,
      'plan_type': instance.planType,
    };
