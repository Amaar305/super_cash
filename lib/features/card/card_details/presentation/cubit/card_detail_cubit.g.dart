// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_detail_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDetailState _$CardDetailStateFromJson(Map<String, dynamic> json) =>
    CardDetailState(
      isCardDetailsExpanded: json['isCardDetailsExpanded'] as bool,
      isCardBillingAddressExpanded:
          json['isCardBillingAddressExpanded'] as bool,
      message: json['message'] as String,
      status: $enumDecode(_$CardDetailStatusEnumMap, json['status']),
      appleProduct: json['appleProduct'] as bool,
      cardDetails: json['cardDetails'] == null
          ? null
          : CardDetails.fromJson(json['cardDetails'] as Map<String, dynamic>),
      appleBillingAddress: BillingAddress.fromJson(
          json['appleBillingAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardDetailStateToJson(CardDetailState instance) =>
    <String, dynamic>{
      'cardDetails': instance.cardDetails,
      'isCardDetailsExpanded': instance.isCardDetailsExpanded,
      'isCardBillingAddressExpanded': instance.isCardBillingAddressExpanded,
      'message': instance.message,
      'status': _$CardDetailStatusEnumMap[instance.status]!,
      'appleProduct': instance.appleProduct,
      'appleBillingAddress': instance.appleBillingAddress,
    };

const _$CardDetailStatusEnumMap = {
  CardDetailStatus.initial: 'initial',
  CardDetailStatus.loading: 'loading',
  CardDetailStatus.success: 'success',
  CardDetailStatus.pinChanged: 'pinChanged',
  CardDetailStatus.failure: 'failure',
};
