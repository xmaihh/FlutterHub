// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..data = json['data'] as Map<String, dynamic>
  ..errorCode = json['errorCode'] as num
  ..errorMsg = json['errorMsg'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
