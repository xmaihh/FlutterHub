// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseListModel<T> _$ResponseListModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseListModel<T>(
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      errorCode: (json['errorCode'] as num).toInt(),
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$ResponseListModelToJson<T>(
  ResponseListModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data?.map(toJsonT).toList(),
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
