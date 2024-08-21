// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner()
  ..bid = json['id'] as num
  ..desc = json['desc'] as String
  ..imagePath = json['imagePath'] as String
  ..isVisible = json['isVisible'] as num
  ..order = json['order'] as num
  ..title = json['title'] as String
  ..type = json['type'] as num
  ..url = json['url'] as String;

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'id': instance.bid,
      'desc': instance.desc,
      'imagePath': instance.imagePath,
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
    };
