// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..cookie = json['cookie'] as String?
  ..theme = json['theme'] as num
  ..cache = json['cache'] == null
      ? null
      : CacheConfig.fromJson(json['cache'] as Map<String, dynamic>)
  ..lastLogin = json['lastLogin'] as String?
  ..locale = json['locale'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'cookie': instance.cookie,
      'theme': instance.theme,
      'cache': instance.cache,
      'lastLogin': instance.lastLogin,
      'locale': instance.locale,
    };
