// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register()
  ..data = json['data'] as Map<String, dynamic>
  ..errorCode = json['errorCode'] as num
  ..errorMsg = json['errorMsg'] as String;

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
