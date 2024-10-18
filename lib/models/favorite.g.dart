// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
      author: json['author'] as String,
      chapterId: (json['chapterId'] as num).toInt(),
      chapterName: json['chapterName'] as String,
      courseId: (json['courseId'] as num).toInt(),
      desc: json['desc'] as String,
      envelopePic: json['envelopePic'] as String,
      id: (json['id'] as num).toInt(),
      link: json['link'] as String,
      niceDate: json['niceDate'] as String,
      origin: json['origin'] as String,
      originId: (json['originId'] as num).toInt(),
      publishTime: (json['publishTime'] as num).toInt(),
      title: json['title'] as String,
      userId: (json['userId'] as num).toInt(),
      visible: (json['visible'] as num).toInt(),
      zan: (json['zan'] as num).toInt(),
    );

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'originId': instance.originId,
      'publishTime': instance.publishTime,
      'title': instance.title,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
