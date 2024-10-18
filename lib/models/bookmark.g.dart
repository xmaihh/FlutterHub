// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      desc: json['desc'] as String,
      icon: json['icon'] as String,
      id: (json['id'] as num).toInt(),
      link: json['link'] as String,
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      visible: (json['visible'] as num).toInt(),
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'desc': instance.desc,
      'icon': instance.icon,
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'userId': instance.userId,
      'visible': instance.visible,
    };
