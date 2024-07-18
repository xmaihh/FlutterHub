// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login()
  ..data = json['data'] as Map<String, dynamic>
  ..errorCode = json['errorCode'] as num
  ..errorMsg = json['errorMsg'] as String;

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
