// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataState _$DataStateFromJson(Map<String, dynamic> json) => DataState(
      message: json['message'] as String,
      phone: Phone.fromJson(json['phone'] as Map<String, dynamic>),
      selectedNetwork: json['selectedNetwork'] as String?,
      status: $enumDecode(_$DataStatusEnumMap, json['status']),
      dataPlans: (json['dataPlans'] as List<dynamic>)
          .map((e) => DataPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedDataType: json['selectedDataType'] as String?,
      filteredPlans: (json['filteredPlans'] as List<dynamic>)
          .map((e) => DataPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedIndex: (json['selectedIndex'] as num?)?.toInt(),
      instantData: json['instantData'] as bool,
      selectedDuration: json['selectedDuration'] as String?,
    );

Map<String, dynamic> _$DataStateToJson(DataState instance) => <String, dynamic>{
      'status': _$DataStatusEnumMap[instance.status]!,
      'dataPlans': instance.dataPlans,
      'filteredPlans': instance.filteredPlans,
      'phone': instance.phone,
      'message': instance.message,
      'selectedDataType': instance.selectedDataType,
      'selectedDuration': instance.selectedDuration,
      'selectedIndex': instance.selectedIndex,
      'selectedNetwork': instance.selectedNetwork,
      'instantData': instance.instantData,
    };

const _$DataStatusEnumMap = {
  DataStatus.initial: 'initial',
  DataStatus.loading: 'loading',
  DataStatus.success: 'success',
  DataStatus.purchased: 'purchased',
  DataStatus.failure: 'failure',
};
