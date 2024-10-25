// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      category: (json['category'] as num).toInt(),
      date: (json['date'] as num).toInt(),
      fromUser: json['fromUser'] as String,
      fromUserId: (json['fromUserId'] as num).toInt(),
      fullLink: json['fullLink'] as String,
      id: (json['id'] as num).toInt(),
      isRead: (json['isRead'] as num).toInt(),
      link: json['link'] as String,
      message: json['message'] as String,
      niceDate: json['niceDate'] as String,
      tag: json['tag'] as String,
      title: json['title'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'category': instance.category,
      'date': instance.date,
      'fromUser': instance.fromUser,
      'fromUserId': instance.fromUserId,
      'fullLink': instance.fullLink,
      'id': instance.id,
      'isRead': instance.isRead,
      'link': instance.link,
      'message': instance.message,
      'niceDate': instance.niceDate,
      'tag': instance.tag,
      'title': instance.title,
      'userId': instance.userId,
    };
