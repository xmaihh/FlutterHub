// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coinInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinInfo _$CoinInfoFromJson(Map<String, dynamic> json) => CoinInfo()
  ..coinCount = json['coinCount'] as num
  ..level = json['level'] as num
  ..nickname = json['nickname'] as String
  ..rank = json['rank'] as String
  ..userId = json['userId'] as num
  ..username = json['username'] as String;

Map<String, dynamic> _$CoinInfoToJson(CoinInfo instance) => <String, dynamic>{
      'coinCount': instance.coinCount,
      'level': instance.level,
      'nickname': instance.nickname,
      'rank': instance.rank,
      'userId': instance.userId,
      'username': instance.username,
    };
