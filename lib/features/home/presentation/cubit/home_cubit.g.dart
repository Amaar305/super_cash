// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => HomeState(
      user: AppUser.fromJson(json['user'] as String),
      status: $enumDecode(_$HomeStatusEnumMap, json['status']),
      message: json['message'] as String,
      showBalance: json['showBalance'] as bool,
    );

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
      'user': instance.user,
      'status': _$HomeStatusEnumMap[instance.status]!,
      'message': instance.message,
      'showBalance': instance.showBalance,
    };

const _$HomeStatusEnumMap = {
  HomeStatus.initial: 'initial',
  HomeStatus.loading: 'loading',
  HomeStatus.success: 'success',
  HomeStatus.failure: 'failure',
};
