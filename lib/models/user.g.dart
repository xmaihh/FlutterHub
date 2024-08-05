// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..coinInfo = json['coinInfo'] == null
      ? null
      : CoinInfo.fromJson(json['coinInfo'] as Map<String, dynamic>)
  ..userInfo = json['userInfo'] == null
      ? null
      : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'coinInfo': instance.coinInfo,
      'userInfo': instance.userInfo,
    };
